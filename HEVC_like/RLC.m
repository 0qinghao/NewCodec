function S=RLC(I)
%======================================================================================================
% ??????????????????????????????????????????(??)?????????
% ??????????????????????????????????????????(??)?????????
% ??????????????????????????????
%------------------------------------------------------------------------------------------------------
% ???5555557777733322221111111 
% ???????5?6??7?5??3?3??2?4??l?7??
%===================================================================================================
[m,n]=size(I);
if m~=1&&n~=1
    I=I';
    I=reshape(I,1,m*n);
end
j=1;
count=1;
% ??????m*n????????
for i=1:m*n-1
    if I(i+1)==I(i)
        count=count+1;
    else
       S(j,1)=I(i);
       S(j,2)=count;
       j=j+1;
       count=1;
    end
end
% ??????????????????????????????????????
% ?????????????S????
if I(m*n)==I(m*n-1)
    S(j,1)=I(i);
    S(j,2)=count;
else
    S(j,1)=I(m*n);
    S(j,2)=1;
end
% I????
% if m==1||n==1
%     S(:,1)=S(:,1)-'0';
%     S=double(S);
% end
end