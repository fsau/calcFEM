pkg load femoctave

N=100;
inds = linspace(0,2*pi,N)';
shell = [cos(inds), sin(inds)];
% shell = [shell; [linspace(-1,1,N)',zeros(N,1)]];
shell = [shell, -ones(size(shell,1),1)];

% shell(abs(shell(:,1))<0.1,3) = 0;
% shell(abs(shell(:,2))<0.1,3) = 0;

% plot(shell(:,1), shell(:,2));

mesh = CreateMeshTriangle('shell',shell,0.001);
mesh = MeshUpgrade(mesh, 'quadratic');

% function res = gD(rz) res = (1-2*(rz(:,2)>0)).*(1-2*(rz(:,1)>0)).*(abs(rz(:,1))>0.1).*(abs(rz(:,2))>0.1); endfunction
function res = gD(rz) res = (1-2*(rz(:,2)>0)).*(1-2*(rz(:,1)>0)); endfunction

u = BVP2Dsym(mesh,1,0,0,'gD',0,0);

figure();
FEMtrisurf(mesh,u);
xlabel('x'); ylabel('y');colorbar();

waitforbuttonpress(); % click on the surface for removing mesh lines
set(gco(),'linestyle','none');
view([0,0,1]);

figure();
FEMtricontour(mesh,u);
xlabel('x'); ylabel('y');colorbar();