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

% Preparing the signal vectors
ch1 = zeros(1,2000);
ch2 = zeros(1,2000);

% Opening the serial connection to the Arduino
s = serial('COM3', 'BaudRate', 9600);
fopen(s);

% Continuously read and classify gestures
while(1)
   i = 1;
   
   while(i <= 2000)
       ch1(i) = fscanf(s);
       ch2(i) = fscanf(s);
       i = i + 1;
   end
   
   % Amplifying, squaring, and finding the mean
   average1 = mean((ch1*10).^2);
   average2 = mean((ch2*10).^2);
    
   % Classifying the gesture, using the data from the library
   % Displaying the results in an image and as text
   if average1 > 5
       gesture = 'fist'
       imshow(fist);
   elseif average1 < 0.3
       if average2 > 1
           gesture = 'up'
           imshow(up);
       else
           gesture = 'flat'
           imshow(flat);
       end
   else
       gesture = 'down'
       imshow(down);
   end
end

% Closing the serial connection to the Arduino
fclose(s);
delete(s)
clear s