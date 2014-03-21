function PressureMap()

l = 20;   %% Length of the total area simulated
w = 10;   %% Width of the total area to simulated
d = 8.5;  %% Distance between the fans, along the l axis
accu =5;  %% Accuracy adjustment.  Sets the distance between each simulated point.
          %% The the area will always be l*w but the accuracy adjustment will change the resolution.
          %% Accuracy changes the speed a lot.  A value of 10 will take a few minutes to run.

    a = zeros(1, 94);
    pres = [0.3, 0.83, 1.04, 1.17, 0.68, 0.12, 0.01, a];
    dist = 0:100;
    pFit = spline(dist, pres);
    
    fan1 = [w/2, l/2 - (d/2)];
    fan2 = [w/2, l/2 + (d/2)];
    P = zeros(w*accu, l*accu);
    y = linspace(0, w, w*accu+1);
    x = linspace(0, l, l*accu+1);
    
    for i = 1:w*accu+1
      for j = 1:l*accu+1
        dist1 = sqrt((y(i)-fan1(1))^2 + (x(j)-fan1(2))^2);
        dist2 = sqrt((y(i)-fan2(1))^2 + (x(j)-fan2(2))^2);
        P(i, j) = ppval(pFit, dist1) + ppval(pFit, dist2);
      end
    end
    
    surf(x, y, P)
end
