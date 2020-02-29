function I2=Surf_PlotSubMesh(M, N, k, l, X)
%k, l�������u���v��Ĵ���
n = N - 1;
m = M - 1;
piece_u = M;   % u��Ľڵ�ʸ��ϸ��
piece_v = N;
Nik_u = zeros(n+1, 1);  % ��������ʼ��
Nik_v = zeros(m+1, 1);

% u�����ϸ��
%% %%%%׼����B������u��ڵ�ʸ��
        NodeVector_u = U_quasi_uniform(n, k); 
        u = linspace(0, 1-0.0001, piece_u);    %% u��ڵ�ֳ����ɷ�
        
        X_M_piece = zeros(M, piece_u);    % ����u���������M * piece
        for i = 1 : M
            for j = 1 : piece_u
                for ii = 0 : 1: n
                    Nik_u(ii+1, 1) = BaseFunction(ii, k , u(j), NodeVector_u);
                end
                X_M_piece(i, j) = X(i, :)* Nik_u;
            end
        end

% v�����ϸ��
  %% ׼����B������v��ڵ�ʸ��
        NodeVector_v = U_quasi_uniform(m, l);  
        v = linspace(0, 1-0.0001, piece_v);    % v��ڵ�ֳ����ɷ�
        
        X_MN_piece = zeros(piece_v, piece_u);
        for i = 1 : piece_u
            for j = 1 : piece_v
                for ii = 0 : 1 : m
                    Nik_v(ii+1, 1) = BaseFunction(ii, l, v(j), NodeVector_v);
                end
            X_MN_piece(j, i) = Nik_v' * X_M_piece(:, i);
            end
        end

        I2=X_MN_piece;

        
       
