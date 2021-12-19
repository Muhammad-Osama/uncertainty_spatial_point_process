function [Y_aug, Z_aug, Phi_aug] = augmented_data(y_tilda,z_tilda,x_tilda,y,Phi,phiB,A)

%Augments new point to existing data

%Input: y_tilda: new counts to be added
%       x_tilda: center of hexagon where counts added
%       y: nx1 vector of observed data
%       Phi: n x R basis matrix of observed data
%       phiB: basis function handle

%Output: Yaug: (n+1)x 1 augmented data
%        Phi_aug: (n+1)xD augmented basis matrix

Y_aug = [y;y_tilda];

Zobs = y./A; Z_aug = [Zobs;z_tilda];

phi_tilda = phiB(x_tilda);

Phi_aug = [Phi;phi_tilda];