% Loading the images to display
fist = imread("fist.jpeg");
flat = imread("flat.jpeg");
up = imread("up.jpeg");
down = imread("down.jpeg");

% Preparing the output figure to display the results
figure('units','normalized','outerposition',[0 0 1 1])
hold on

% Setting the time interval to 2 seconds
n = 2000;

% Reading the signal from the saved file
ch1 = h5read("demo.hdf5", '/channels/channel_0');
ch2 = h5read("demo.hdf5", '/channels/channel_1');

% Iterating over the signal
j = 1:n:length(ch1);
k = n:n:length(ch1);
k = [k length(ch1)];

for i = 1:length(j)
    
    % Resetting the output image index when full
    z = mod(i,12);
    if z == 0
        z = 12;
    end
    
    % Dividing the signal for processing
    temp1 = ch1(j(i):k(i));
    temp2 = ch2(j(i):k(i));
    
    % Amplifying, squaring, and finding the mean
    average1 = mean((temp1*10).^2);
    average2 = mean((temp2*10).^2);
    
    % Classifying the gesture, using the data from the library
    % Displaying the results in an image and as text
    if average1 > 5
        gesture = 'fist'
        subplot(3,4,z);
        imshow(fist);
        title(i);
    elseif average1 < 0.3
        if average2 > 1
            gesture = 'up'
            subplot(3,4,z)
            imshow(up);
            title(i);
        else
            gesture = 'flat'
            subplot(3,4,z)
            imshow(flat);
            title(i);
        end
    else
        gesture = 'down'
        subplot(3,4,z)
        imshow(down);
        title(i);
    end
    
    % Creating a new output image when full
    if z == 12
        hold off
        figure('units','normalized','outerposition',[0 0 1 1])
        hold on
    end
    
end