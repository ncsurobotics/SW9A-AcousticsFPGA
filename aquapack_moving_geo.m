close all;
clear;
%Parameters
global f_signal awgn_snr
f_signal = 25e3; % initial frequency of signal emitted by pinger
%arrival_ang_estimate = 120; % degrees arrival angle (changeable)
%arrival_ang_rad = deg2rad(arrival_ang_estimate); % arrival angle in rad
pinger_distance = 30;
awgn_snr = 0;

% update options
global rotate_robot move_pinger
rotate_robot = false; % automated rotation of robot
move_pinger = false; %automated movement of pinger|
use_user_update_flag = true; % only updates the screen when a robot value changes
best_guess_angle_rel = 1;
angle_error_deg = 1;

% plot options
plot_array_signals = true;
plot_weight_polar = true;
plot_weight_stem = true;
plot_directivity = true;
plot_fft = true;
plot_robot = true;
framecount = 10e5; 
framespeed = 0.1; % seconds per frame
degreesperframe = 2.5; %degrees that the pinger moves each frame

%constants
c = 1480; %speed of sound in water m/s
alpha = 1e-3; % constant for amplitude decay
fs = 250e3; % sampling freq
hydrophone_diameter = 0.0254; % physical constraint for the hydrophones
sample_count = 512; % 512 samples at 512khz fs means each bin the fft output is 1khz.
dec_factor = 1; % downsampling factor - we dont need to downsample
r0=5; % reference distance in meters. minimum distance from hydrophones to signal
% THIS STUFF IS WRONG
%spacing_constant = c / (2*d); % this value is what lambda should be, but physical constraints
array_graph_scale = 50; % affects robot view
robot_graph_limits = 50;
guess_vec_count = 1; % number of vectors to best guesses of the pinger
num_of_bits = 12;



% --- Signal generation ---
theta = deg2rad(0:1:360); % define angle range
sample_time = sample_count / fs;           % seconds for sample_count samples
n = 0:1/fs:sample_time-1/fs;               % discrete time vector
N = length(n);
global ha_list ha_idx hydrophone_array
ha_idx = 1;
% Array definition
d = 0.0254; % ideally should be lambda/2, this is the physical value though
% T shape
t_array = [0 0 0
                    d 0 0
                    2*d 0 0
                    3*d 0 0
                    0*d d 0
                    0*d -d 0];
% Cross shape
cross_array = [0 0 0
    d 0 0
    2*d 0 0
    3*d 0 0
    1.5*d 0.022 0
    1.5*d -0.022 0];
% ULA
ul_array = [0 0 0
    d 0 0
    2*d 0 0
    3*d 0 0
    4*d 0 0
    5*d 0 0];
% parallelogram array
parallel_d = 0.0180; % minimum distance with 0.0254 distance between hydrophones
parallelogram_array = [0 0 0
    parallel_d parallel_d 0
    2*parallel_d 0 0
    3*parallel_d parallel_d 0
    4*parallel_d 0 0
    5*parallel_d parallel_d 0];
hex_d = d;
hex_array = [cos(0)*hex_d sin(0)*hex_d 0
    cos(pi/3)*hex_d sin(pi/3)*hex_d 0
    cos(2*pi/3)*hex_d sin(2*pi/3)*hex_d 0
    cos(3*pi/3)*hex_d sin(3*pi/3)*hex_d 0
    cos(4*pi/3)*hex_d sin(4*pi/3)*hex_d 0
    cos(5*pi/3)*hex_d sin(5*pi/3)*hex_d 0];
penta_d = d;
penta_array = [cos(0)*penta_d sin(0)*penta_d 0
    cos(2*pi/5)*penta_d sin(2*pi/5)*penta_d 0
    cos(2*2*pi/5)*penta_d sin(2*2*pi/5)*penta_d 0
    cos(3*2*pi/5)*penta_d sin(3*2*pi/5)*penta_d 0
    cos(4*2*pi/5)*penta_d sin(4*2*pi/5)*penta_d 0
    0 0 0];
tri_d = 3*d/4;
tri_d_scale = 1.55;
tri_array = [cos(0)*tri_d sin(0)*tri_d 0
    cos(2*pi/3)*tri_d sin(2*pi/3)*tri_d 0
    cos(4*pi/3)*tri_d sin(4*pi/3)*tri_d 0
    cos(1*pi/3)*tri_d*tri_d_scale sin(1*pi/3)*tri_d*tri_d_scale 0
    cos(3*pi/3)*tri_d*tri_d_scale sin(3*pi/3)*tri_d*tri_d_scale 0
    cos(5*pi/3)*tri_d*tri_d_scale sin(5*pi/3)*tri_d*tri_d_scale 0];
semi_d = d*1.31;
semi_array = [cos(0)*semi_d sin(0)*semi_d 0
    cos(pi/4)*semi_d sin(pi/4)*semi_d 0
    cos(2*pi/4)*semi_d sin(2*pi/4)*semi_d 0
    cos(3*pi/4)*semi_d sin(3*pi/4)*semi_d 0
    cos(4*pi/4)*semi_d sin(4*pi/4)*semi_d 0
    0 0.0079 0]
ha_list = {ul_array t_array cross_array parallelogram_array hex_array penta_array tri_array semi_array};
ha_idx = 6;
hydrophone_array = ha_list{ha_idx};

Dvec = pdist(hydrophone_array);
minD = min(Dvec)
center = mean(hydrophone_array,1);
hydrophone_array = hydrophone_array -center;
H = length(hydrophone_array); % number of hydrophones


% Allocation
mobile_h_array = zeros(H,3); % hydrophone array that follows robot_pos
mobile_h_array_scaled = zeros(H,3); % hydrophone array that follows robot_pos. Scaled up for visualization but not accurate
hydro_dec = zeros(H,N/dec_factor);
hydro = zeros(H, N);
grating_lobes = zeros(1,length(theta));
R = zeros(H,H); % allocate space for x(t)*x(t)^H
% Calculate P(theta) for every theta
magP = zeros(1,length(theta));
polar_rlim = 0.01;
guess_vectors = zeros(2,guess_vec_count);
gv_length = zeros(4);
array_factor = zeros(H,length(theta)); % allocate space for array manifold
directivity = zeros(1,length(theta)); % directivity is summed array_factor
pinger_angle_abs = 0;
global p_norm robot_pos robot_facing update_flag pinger_loc show_pinger window_size delay_correction
delay_correction = false;
robot_pos = [0 0 0];
robot_facing = [1 0 0];
update_flag = false;
pinger_loc = [0 pinger_distance 0]; % starting location of pinger
show_pinger = true;
window_size = 1;
p_norm = false;




if plot_weight_stem
    stem_fig = figure('Name','StemPlot');
    theta_deg = theta*180/pi;
    angle_stemP = plot(theta_deg, magP);
    hold on;
    %angle_gratingP = plot(theta_deg,grating_lobes,'r','LineWidth',1);
    xlabel('\theta (deg)'); ylabel('P(\theta)');
    title("Angle weights (stem)");
    grid on;
end

if plot_fft
    fft_fig = figure('Name','FFT Spectrum');
    fft_freq = (0:N-1) * fs / N;
    fft_plot = plot(fft_freq, zeros(1,N), 'LineWidth',1.2);
    xlabel('Frequency (Hz)'); ylabel('Magnitude');
    title('Hydrophone FFT'); grid on;
end


if plot_weight_polar
    polar_fig = figure('Name',"Polar Weights");
    pax = polaraxes;
    angle_polarP = polarplot(pax, theta, magP, '-b','LineWidth',1.5);
    rlim(pax, [0 polar_rlim]);
    hold(pax,'on');
    % hydrophone markers (store handles
    r_pinger = 0.6;
    hydro_angles = atan2(hydrophone_array(:,2), hydrophone_array(:,1));
    r_hydro = sqrt(hydrophone_array(:,2).^2+hydrophone_array(:,1).^2);
    hydro_polarP = polarplot(pax, hydro_angles, r_hydro, 'ko', 'MarkerFaceColor','k','MarkerSize',6);
    pinger_polarP = polarplot(pax, atan2(pinger_loc(2)-robot_pos(2), pinger_loc(1)-robot_pos(1)), r_pinger, 'r*', 'MarkerSize',10);
    title(pax,'Polar beamforming');
    hold(pax,'off');
end
% small helper: ternary function since MATLAB anonymous can't use ?: operator
function out = ternary(cond, a, b)
if cond
    out = a;
else
    out = b;
end
end

if plot_array_signals
    sig_fig = figure('Name','Signals at Hydrophones');
    t_plot = (0:N/4-1)/fs;
    signals_P = gobjects(H,1);
    hold on;
    for i = 1:H
        signals_P(i) = stairs(t_plot, zeros(1, length(t_plot)), 'DisplayName', ['Hydrophone ' num2str(i)]);
    end
    hold off;
    title('Received Signals from Hydrophones');
    xlabel('time (s)'); ylabel('Amplitude');
    legend show; grid on;
    
    % Create a panel for checkboxes inside the animation figure (right side)
    cbPanel = uipanel('Parent', sig_fig, 'Title', 'Show Signals', ...
        'Units','normalized', 'Position',[0.78 0.25 0.20 0.35]); % adjust position as needed
    
    % Create a checkbox for each hydrophone that toggles the corresponding plot
    for i = 1:H
        % vertical stacking: compute normalized position
        posY = 1 - i*(1/(H+1));
        uicontrol(cbPanel, 'Style','checkbox', 'String', ['Hydrophone ' num2str(i)], ...
            'Units','normalized', 'Position',[0.05 posY 0.9 0.08], ...
            'Value', 1, ...
            'Callback', @(src,~) set(signals_P(i), 'Visible', ternary(src.Value==1, 'on', 'off')));
    end
    

end 


if plot_directivity
    % Create figure
    dir_fig = figure("Name","Directivity");
    dir_p = polarplot(theta, directivity); 
    grid on;
end


% Robot motion view
robot_fig = figure('Name',"Robot View");
axRobot = gca;
hold(axRobot,'on');
axis(axRobot,'equal');
grid(axRobot,'on');
xlabel(axRobot,'x (m)'); ylabel(axRobot,'y (m)');
xlim([-robot_graph_limits  robot_graph_limits ]);
ylim([-robot_graph_limits  robot_graph_limits ]);
title(axRobot,'Robot, Array, and Pinger');

% initial placeholders (will update in loop)
robot_h = plot(axRobot, robot_pos(1), robot_pos(2), 'bs', 'MarkerFaceColor','b', 'DisplayName','Robot');
facing_h = quiver(axRobot, robot_pos(1), robot_pos(2), robot_facing(1), robot_facing(2), 30, 'r', 'LineWidth',3, 'DisplayName','Facing');
mobile_h_plot = scatter(axRobot, mobile_h_array_scaled(:,1), mobile_h_array_scaled(:,2), 20, 'ko', 'filled', 'DisplayName','Mobile Hydrophones');
mobile_line = plot(axRobot, mobile_h_array_scaled(:,1), mobile_h_array_scaled(:,2), '-k', 'HandleVisibility','off');
pinger_h = plot(axRobot, pinger_loc(1), pinger_loc(2), 'r*', 'MarkerSize',10, 'DisplayName','Pinger');
gv_h = gobjects(guess_vec_count);
for i= 1:guess_vec_count
    gv_h(i) = quiver(axRobot,robot_pos(1), robot_pos(2),guess_vectors(1,i),guess_vectors(2,i),gv_length(i)*20,'g','LineWidth',2,'DisplayName','Guess');
end
% create a status text in normalized figure units (updateable)
status_h = uicontrol(robot_fig, 'Style','text', ...
    'Units','normalized', 'Position',[0.76 0.02 0.22 0.04], ...
    'String', sprintf('Freq: %.0f Hz', f_signal), ...
    'FontSize',10, 'HorizontalAlignment','left');
pinger_height_h = uicontrol(robot_fig, 'Style','text', ...
    'Units','normalized', 'Position',[0.76 0.07 0.22 0.04], ...
    'String', sprintf('Pinger Height: %d', pinger_loc(3)), ...
    'FontSize',10, 'HorizontalAlignment','left');
robot_height_h = uicontrol(robot_fig, 'Style','text', ...
    'Units','normalized', 'Position',[0.76 0.12 0.22 0.04], ...
    'String', sprintf('Robot Height: %d', robot_pos(3)), ...
    'FontSize',10, 'HorizontalAlignment','left');
% place this after creating the robot/pinger/guess plot handles
distance_txt = text(axRobot, -robot_graph_limits+2, robot_graph_limits-4, ...
    sprintf('Dist: %.1f m', norm(pinger_loc(1:2)-robot_pos(1:2))), ...
    'FontSize',10, 'FontWeight','bold', 'BackgroundColor','w', 'EdgeColor','k', ...
    'Margin',4, 'HorizontalAlignment','left');
% angle text (placed slightly below distance text)
angle_deg = rad2deg( atan2(pinger_loc(2)-robot_pos(2), pinger_loc(1)-robot_pos(1)) );
az_txt = text(axRobot, -robot_graph_limits+2, robot_graph_limits-10, ...
    sprintf('Azimuth Angle: %.1f°', angle_deg), ...
    'FontSize',10, 'FontWeight','bold', 'BackgroundColor','w', 'EdgeColor','k', ...
    'Margin',4, 'HorizontalAlignment','left');
el_txt = text(axRobot, -robot_graph_limits+2, robot_graph_limits-16, ...
    sprintf('Elevation Angle: %.1f°', angle_deg), ...
    'FontSize',10, 'FontWeight','bold', 'BackgroundColor','w', 'EdgeColor','k', ...
    'Margin',4, 'HorizontalAlignment','left');
angle_err_txt = text(axRobot, -robot_graph_limits+2, robot_graph_limits-22, ...
    sprintf('Angle Error: %.1f°', angle_error_deg), ...
    'FontSize',10, 'FontWeight','bold', 'BackgroundColor','w', 'EdgeColor','k', ...
    'Margin',4, 'HorizontalAlignment','left');

legend(axRobot,'Location','bestoutside');
hold(axRobot,'off');

function bdf(~, event)
    % Parameters for movement/rotation (tweak as desired)
    moveStep = 1;    % meters per keypress
    rotDeg   = 2.5;    % degrees per keypress
    global robot_pos robot_facing update_flag pinger_loc f_signal show_pinger window_size awgn_snr ha_list ha_idx hydrophone_array rotate_robot move_pinger p_norm delay_correction
    update_flag = true;
    % Ensure robot_facing is 2D direction (ignore z)
    f = robot_facing(1:2);
    if ~all(isfinite(f)) || norm(f) == 0
        f = [1 0]; % fallback facing
    end
    right_vec = f / norm(f);          % unit forward vector
    forward = [-right_vec(2), right_vec(1)];     % unit left vector (90 deg CCW)

    switch event.Key
        case "w"   % forward
            robot_pos(1:2) = robot_pos(1:2) + moveStep * forward;
        case "s"   % backward
            robot_pos(1:2) = robot_pos(1:2) - moveStep * forward;
        case "a"   % left
            robot_pos(1:2) = robot_pos(1:2) - moveStep * right_vec;
        case "d"   % right
            robot_pos(1:2) = robot_pos(1:2) + moveStep * right_vec;
        case "q"   % rotate left (CCW)
            ang = deg2rad(rotDeg);
            R = [cos(ang), -sin(ang); sin(ang), cos(ang)];
            newf = (R * f')';
            if ~all(isfinite(newf)) || norm(newf)==0
                newf = f;
            end
            newf = newf / norm(newf);
            robot_facing = [newf, robot_facing(3)];
        case "e"   % rotate right (CW)
            ang = deg2rad(-rotDeg);
            R = [cos(ang), -sin(ang); sin(ang), cos(ang)];
            newf = (R * f')';
            if ~all(isfinite(newf)) || norm(newf)==0
                newf = f;
            end
            newf = newf / norm(newf);
            robot_facing = [newf, robot_facing(3)];
        case "uparrow" %move pinger up
            pinger_loc = pinger_loc + [0 2 0];
        case "downarrow" %move pinger down
            pinger_loc = pinger_loc + [0 -2 0];
        case "leftarrow" %move pinger left
            pinger_loc = pinger_loc + [-2 0 0];
        case "rightarrow" %move pinger up
            pinger_loc = pinger_loc + [2 0 0];
        case "v" %move pinger up in z plane
            pinger_loc = pinger_loc + [0 0 2];
        case "b" %move pinger down in z plane
            pinger_loc = pinger_loc + [0 0 -2];
        case "n" %move robot up
            robot_pos(3) = robot_pos(3) + 0.5;
        case "m" %move robot down
            robot_pos(3) = robot_pos(3) - 0.5;            
        case "1" % use freq 1 = 25k
            f_signal = 25e3
        case "2" % use freq 2 = 30k
            f_signal = 30e3
        case "3" % use freq 3 = 35k
            f_signal = 35e3
        case "4" % use freq 4 = 40k
            f_signal = 40e3
        case "5"
            f_signal = f_signal - 500;
        case "6"
            f_signal = f_signal + 500;
        case "h" % hide pinger
            show_pinger = ~show_pinger
        case "r" % randomize pinger
            z = pinger_loc(3);
            pinger_loc = [rand()*80-40,rand()*80-40, z];
        case "x" % widen window
            window_size = window_size + 1
        case "z" %decrease window
            window_size = max(window_size-1,0)
        case "l" %increase snr
            awgn_snr = awgn_snr+1
        case "k" % decrease snr
            awgn_snr = awgn_snr-1
        case "g" % cycle array geometry
            ha_idx = mod(ha_idx, numel(ha_list)) + 1;   % advance index cyclically
            hydrophone_array = ha_list{ha_idx};
            Dvec = pdist(hydrophone_array);
            minD = min(Dvec)
            center = mean(hydrophone_array,1);
            hydrophone_array = hydrophone_array - center;
        case "j"
            % random small perturbation to one hydrophone coordinate but enforce min spacing
            maxAttempts = 10;
            pertMag = 0.1; % maximum per-coordinate perturbation
            success = false;
            hydrophone_diameter = 0.0254;
            for attempt = 1:maxAttempts
                newArray = hydrophone_array;
                rx_idx = randi(size(hydrophone_array,1));
                ry_idx = randi([1,3]);
                newArray(rx_idx,ry_idx) = newArray(rx_idx,ry_idx) + (rand()-0.5)*2*pertMag;
                % compute pairwise distances
                D = pdist(newArray);
                if all(D >= hydrophone_diameter)  % keep if all distances >= min allowed
                    hydrophone_array = newArray;
                    success = true;
                    break;
                end
            end
            if ~success
                % optionally notify or ignore if no valid perturbation found
                % disp('Perturbation rejected: would violate min spacing');
            end
        case "t" % rotate robot
            rotate_robot = true;
        case "y" % move pinger
            move_pinger = true;
        case "u" % switch p_mag mode
            p_norm = not(p_norm);
            p_norm
        case "i" % toggle delay_correction
            delay_correction = not(delay_correction)
    end
end

figure("KeyPressFcn",@bdf,"Name","Keyboard Input");
annotation('textbox',[0.10 0.05 0.35 0.08], ...
    'String','This figure must be active for keyboard input to work. Click inside figure to make it active.', ...
    'FitBoxToText','on','Interpreter','none');disp("Use WASD to move the robot, QE to rotate the robot")
disp("Arrow keys to move the pinger.")
disp("1-25khz,2-30khz,3-35khz,4-40khz")
disp('"r" to randomize the pinger location, "h" to hide the pinger.')
disp('"x" and "z" to widen or decrease the window for the rmax calculation.')
disp('"l" to set SNR to 100 (no noise), "k" to set SNR to 0.001 (lots of noise)')
disp('"g" cycle through array geometry options')
disp('"j" perturb array locations')
disp('"v" move pinger up')
disp('"b" move pinger down')
disp('"n" move robot up')
disp('"m" move robot down')
disp("All distance units are in meters unless otherwise specified")

% --- Wait for user to press Play ---
ctrlFig = figure('Name','Controls','NumberTitle','off','MenuBar','none',...
    'ToolBar','none','Position',[100 100 200 80]);

uicontrol(ctrlFig,'Style','pushbutton','String','Play','FontSize',12, ...
    'Position',[25 20 150 40], ...
    'Callback', @(~,~) uiresume(ctrlFig));

% Pause here until Play is pressed
uiwait(ctrlFig);
close(ctrlFig);  % optional: close control window after starting
% --- Continue to the main loop ---

rotation_frames = 0;


for frame=0:framecount

    if rotate_robot
        robot_facing=[cos(deg2rad(rotation_frames  * degreesperframe)), sin(deg2rad(rotation_frames * degreesperframe)), 0]; 
        rotation_frames = rotation_frames +1;
        if mod(degreesperframe*rotation_frames,90) <= 0.1
            rotate_robot = false;
        end
        update_flag = true;
    end


    % Update after each iteration
    % The pinger orbits the hydrophones, then orbits while slowly ascending
    % determine plotting radius scale
    if move_pinger
        pinger_loc = [pinger_distance*cos(deg2rad(rotation_frames * degreesperframe)), pinger_distance*sin(deg2rad(rotation_frames* degreesperframe)), 10]; 
        rotation_frames = rotation_frames + 1;
        if mod(degreesperframe*rotation_frames,90) <= 0.1
            move_pinger = false;
        end
        update_flag = true;
    end

    if update_flag || ~use_user_update_flag
        % Rotate hydrophone array in the XY plane only (preserve z)
        % Compute facing angle from robot_facing (use XY components)
        facingAngle = atan2(robot_facing(2), robot_facing(1));
        Rz = [cos(facingAngle), -sin(facingAngle), 0;
              sin(facingAngle),  cos(facingAngle), 0;
              0,                 0,                1];
        % Apply rotation to XY and translate; keep original z offsets
        rotated = (Rz * hydrophone_array.').';
        mobile_h_array = rotated + robot_pos;        % broadcast adds robot_pos to each row
        % Ensure z component is preserved as hydrophone_array original z plus robot z
        mobile_h_array(:,3) = hydrophone_array(:,3) + robot_pos(3);
    
        % distances and relative delays (seconds)
        signal_distance = vecnorm(mobile_h_array - pinger_loc, 2, 2); % Hx1
        tau = signal_distance / c;                % absolute delay to each hydrophone (s)
        acquisition_time = 1e-6; % 300ns according to documentation + 50ns for control logic (idk if this is necessary, worst case)
        acquisition_delays = [0 0 acquisition_time acquisition_time 2*acquisition_time 2*acquisition_time]';
        tau = tau + acquisition_delays  ;
        %scaling to represent lower amplitude with distance
        % choose reference distance r0 (use provided r0 as reference)
        r0 = max(r0, 1e-6);                       % avoid div/zero
        amp = (r0 ./ signal_distance) .* (1 - alpha .* (signal_distance - r0)); 
        amp(signal_distance<=r0) = 1;             % clamp near reference
        amp(:) = 1; %override to remove attenuation
        
        % generate hydrophone signals (fractional delays by time-shift in argument)
        for h = 1:H
            hydro(h,:) = amp(h) * sin(2*pi*f_signal*(n - tau(h)));
        end
        
        % determine reference microphone = earliest arrival (smallest tau) 
        %[~, refIdx] = min(tau);
        %refmic = hydro(refIdx, :);
        
        
        % Add AWGN noise to signals
        signalPower = rms(hydro(:,1))^2;
        %quantization_snr = 10*log10(signalPower/1)+4.8+6* num_of_bits;
        %hydro = awgn(hydro,79,"measured"); % quantization snr
        
        [hydroNoisey, noiseVar] = awgn(hydro,awgn_snr,'measured'); % 2nd parameter is SNR
        %hydroNoisey = quantizenumeric(hydroNoisey,1,12,11,'nearest','saturate')
        hydroNoisey = quantizenumeric(hydroNoisey,1,12,11,'nearest','saturate');
        % Decimate hydrophone signals
        for h = 1 : H
            hydro_dec(h,:) = hydroNoisey(h,1:dec_factor:end);
        end
        
        % Normalize hydrophone data [-1, 1]
        maximum = max(hydro_dec,[],"all");
        minimum = min(hydro_dec,[],"all");
        hydro_dec = (hydro_dec - minimum)/(maximum - minimum);
        hydro_dec = 2 * hydro_dec - 1;
        
        
        %Bartlett Algo
        % THIS STUFF IS WRONG
        %k = 1*j*pi*f_signal/spacing_constant; % constant
        %indices = 0:1:H-1;
        %a = zeros(H,length(theta)); % allocate space for array manifold
        % Create array manifold (for each angle in theta, there is a 4x1 steering vector s(theta))
        %for i=1:length(theta)
        %    a(:,i) = exp(indices*k*cos(theta(i))); % s(theta)
        %end
        
        %k = 2*pi/(c/f_signal); % constant equivalent to the below formula
        k = f_signal * pi * 2/c;
        % Create array manifold (for each angle in theta, there is a 4x1 steering vector s(theta))
        for i=1:length(theta)
            distance = cos(theta(i))*hydrophone_array(:,1) + sin(theta(i))*hydrophone_array(:,2); % get vertical and horizontal distance
            %distance2 = (cos(theta(i))*hydrophone_array(:,1)).^2 + (sin(theta(i))*hydrophone_array(:,2)).^2; % get vertical and horizontal distance
            %distance2 = sqrt(distance2);
            %disp('Proj distance:'); disp(distance.');
            %disp('Radial distance:'); disp(distance2.');
            %disp('Difference:'); disp((distance2-distance).');

            array_factor(:,i) = exp(1j*k*distance); % s(theta) = e^j * (distance * radians/meter)


        end

        hydro_dec_freq = fft(hydro_dec,[],2); % hydro_dec now complex
        %hydro_dec_freq = hydro_dec;
        
        % hydro_dec is 4×256
        % Find max bin using channel 1 only
        [~, idx] = max(abs(hydro_dec_freq(1,:)));

        window = window_size;
        numRows = size(hydro_dec_freq,1);

        sumVals = zeros(numRows,1);   % complex sums
        sumMags = zeros(numRows,1);   % optional

        startIdx = max(1, idx - window);
        stopIdx  = min(size(hydro_dec_freq,2), idx + window);

        for r = 1:numRows
            segment = hydro_dec_freq(r, startIdx:stopIdx);
            sumVals(r) = sum(segment);          % complex sum
            sumMags(r) = sum(abs(segment));     % optional
        end

        if delay_correction
            sumVals = sumVals .* exp(f_signal * j * 2 * pi * acquisition_delays);
        end

        R = sumVals * sumVals';
        % dont divide R, because the power is distributed evenly among the
        % window
        %R = R / (stopIdx - startIdx + 1);

        P = zeros(1,length(theta));
    
        % Normalize P by s(theta)^H*s(theta)
        for i=1:length(theta)
            P(i) = array_factor(:,i)'*R*array_factor(:,i) / (array_factor(:,i)'*array_factor(:,i));
            %imag(P(i));
            if p_norm %apparently P is always all real
                magP(i) = norm(P(i)); 
            else 
                magP(i) = real(P(i));
            end
        end




        guess_idx = min(guess_vec_count, numel(magP));
        [topVals, topIdx] = maxk(magP, guess_idx);   % topVals: values, topIdx: indices into magP
        gv_angles = theta(topIdx);
        best_guess_angle_rel = gv_angles(1);

        
        % Build guess vectors (2 x guess_vec_count). Each column = endpoint [x;y;z]
        guess_vectors = nan(2, guess_vec_count);
        % display length for guess vectors (tweak if desired)
        gv_length = robot_graph_limits/2;
        robot_angle = atan2(robot_facing(2),robot_facing(1));
        for ii = 1:guess_idx
            ang = gv_angles(ii) + robot_angle;
            dir = [cos(ang); sin(ang)];            % unit direction in world frame
            guess_vectors(:,ii) = gv_length * dir;
        end


        if plot_weight_stem
            angle_stemP.YData = magP;
        end

        % pinger_polarP.YData = r_pinger;
        %hydro_polarP.YData = r_hydro;
        if plot_array_signals
            for h = 1:H
                signals_P(h).YData = hydro_dec(h,1:N/4);
            end
        end
        if frame~=0 && mod(frame,360)==0
            f_signal = f_signal + 0e3;
            disp(f_signal)
        end
        if plot_robot
            % Update robot marker and facing arrow
            set(robot_h, 'XData', robot_pos(1), 'YData', robot_pos(2));
            % rotate vector to face to the side
            set(facing_h, 'XData', robot_pos(1), 'YData', robot_pos(2), ...
                'UData', -robot_facing(2), 'VData', robot_facing(1));

            mobile_h_array_scaled = (mobile_h_array-robot_pos)*array_graph_scale + robot_pos;
            % Update mobile hydrophones and connecting line
            set(mobile_h_plot, 'XData', mobile_h_array_scaled(:,1), 'YData', mobile_h_array_scaled(:,2));
            set(mobile_line, 'XData', mobile_h_array_scaled(:,1), 'YData', mobile_h_array_scaled(:,2));

            % Update pinger location
            if show_pinger
                set(pinger_h, 'XData', pinger_loc(1), 'YData', pinger_loc(2));
                % update displayed distance (inside if plot_robot)
                distRP = norm(pinger_loc(1:2) - robot_pos(1:2));
                if exist('distance_txt','var') && isgraphics(distance_txt)
                    set(distance_txt, 'String', sprintf('XY Dist: %.2f m', distRP));
                end
                if exist('az_txt','var') && isgraphics(az_txt)
                    set(az_txt, 'String', sprintf('Azimuth Angle: %.1f°', rad2deg(pinger_angle_abs-robot_angle)));
                end
                % Update elevation angle (degrees)
                if exist('el_txt','var') && isgraphics(el_txt)
                    % compute elevation = atan2( delta_z, horizontal_distance )
                    horizDist = max(distRP, 1e-9); % avoid div/zero
                    elevRad = atan2(pinger_loc(3) - robot_pos(3), horizDist);
                    elevDeg = rad2deg(elevRad);
                    set(el_txt, 'String', sprintf('Elevation Angle: %.1f°', elevDeg));
                end
                if exist('angle_err_txt','var') && isgraphics(angle_err_txt)
                    correct_angle_rel = mod(pinger_angle_abs - robot_angle + pi, 2*pi) - pi;
                    angle_error_deg = abs(rad2deg(mod(correct_angle_rel - best_guess_angle_rel + pi, 2*pi) - pi));
                    set(angle_err_txt, 'String', sprintf('Angle Error: %.1f°', angle_error_deg));
                end


            else
                set(pinger_h, 'XData', 0, 'YData', 0);
                if exist('distance_txt','var') && isgraphics(distance_txt)
                    set(distance_txt, 'String', "");
                end
                if exist('angle_txt','var') && isgraphics(angle_txt)
                    set(angle_txt, 'String', "");
                end
                if exist('angle_err_txt','var') && isgraphics(angle_err_txt)
                    set(angle_err_txt, 'String', "");
                end

            end
            for i = 1:guess_vec_count   
                set(gv_h(i),'XData', robot_pos(1), 'YData', robot_pos(2),'UData', guess_vectors(1,i), 'VData', guess_vectors(2,i));
            end
        end

        if plot_weight_polar
            angle_polarP.YData = magP;
            polar_rlim = max(magP);
            pax.RLim=[0 polar_rlim ];
            % absolute angle from robot to pinger
            pinger_angle_abs = atan2(pinger_loc(2)-robot_pos(2), pinger_loc(1)-robot_pos(1));
            % robot facing angle
            facingAngle = atan2(robot_facing(2), robot_facing(1));
            % relative angle (0 = robot_facing). wrap to [0, 2*pi)
            pinger_angle_rel = mod(pinger_angle_abs - facingAngle, 2*pi);
            hydro_angles = atan2(hydrophone_array(:,2), hydrophone_array(:,1));
            r_hydro = sqrt(hydrophone_array(:,2).^2+hydrophone_array(:,1).^2) * 10 * polar_rlim;
            set(hydro_polarP,"ThetaData",hydro_angles,"RData",r_hydro);
            pinger_polarP.XData = pinger_angle_rel;

        end
        % update displayed frequency
        if exist('status_h','var') && isgraphics(status_h)
            set(status_h, 'String', sprintf('Freq: %.0f Hz', f_signal));
        end
        if exist('pinger_height_h','var') && isgraphics(pinger_height_h)
            set(pinger_height_h, 'String', sprintf('Pinger Height: %d', pinger_loc(3)));
        end
        if exist('robot_height_h','var') && isgraphics(robot_height_h)
            set(robot_height_h, 'String', sprintf('Robot Height: %.1f', robot_pos(3)));
        end

        if plot_directivity
            for i=1:numel(theta)
                directivity(i) = abs(sum(array_factor(:,i)));
            end
            dir_p.YData = directivity;
        end

        if plot_fft
            fftMagnitude = abs(hydro_dec_freq(1,:));
            fft_plot.YData = fftMagnitude;
            fft_plot.XData = (0:size(hydro_dec_freq,2)-1) * fs / size(hydro_dec_freq,2);
            xlim(fft_fig.CurrentAxes, [0 fs/2]);
        end % end plot_fft




    end %end if robot_flag or not use_robot_flag


    
    if use_user_update_flag %if using robot flag we wait for it to go high to continue
        if update_flag
            drawnow limitrate;
            update_flag = 0;
        end
    else
        drawnow limitrate;
    end
    pause(framespeed) 
end