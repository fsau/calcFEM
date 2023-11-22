pkg load femoctave

N=50;
inds = linspace(0,2*pi,N)';
shell = [cos(inds), sin(inds)];
% shell = [shell; [linspace(-1,1,N)',zeros(N,1)]]; % close half-sphere (old)
shell = [shell, -ones(size(shell,1),1)]; % add boundary condition (Dirichlet)

% shell(abs(shell(:,1))<0.1,3) = -2; % uncomment both line to use space (Neumann) between plates
% shell(abs(shell(:,2))<0.1,3) = -2;

% plot(shell(:,1), shell(:,2)); % plot shell

mesh = CreateMeshTriangle('shell',shell,0.0005); % need 'triangle' installed on system, see FEMoctave docs
mesh = MeshUpgrade(mesh, 'quadratic');

function res = gD(rz) res = (1-2*(rz(:,2)>0)).*(1-2*(rz(:,1)>0)); endfunction % Dirchlet boundary value (potential)

u = BVP2Dsym(mesh,1,0,0,'gD',0,0); % do the magic

% figure(); % Uncomment to plot surface:
% FEMtrisurf(mesh,u); % surface plot
% xlabel('x'); ylabel('y');colorbar();
% % waitforbuttonpress(); % click on the surface for removing mesh lines
% % set(gco(),'linestyle','none');
% view([0,0,1]);
% grid();

% figure(); % Uncomment to plot countour:
% FEMtricontour(mesh,u); % contour
% xlabel('x'); ylabel('y');colorbar();

% figure(); % Uncomment to plot comparasion:
% tinds = linspace(0,2*pi,200)';
% for testr = 0.1:0.2:0.9
%     testcirc = testr.*[cos(inds), sin(inds)];
%     [a,b,c] = FEMgriddata(mesh,u,testcirc(:,1),testcirc(:,2));
%     plot(inds,a,'color','blue');
%     hold on

%     % Analytic solution (summation):
%     Vi = @(r, theta, i) sin(2*(2*i-1).*theta)./(2*i-1).*r.^(2*(2*i-1));
%     V = @(r,theta,n) 4/pi*sum(Vi(r,theta,1:n)');
%     plot(tinds,V(testr,tinds,100),'color','red');
% endfor
% legend('Resultado numérico','Solução analítica');
% xlabel('\theta'); ylabel('V'); 
