function [ trainCCR,testCCR ] = calCCR( net,input,testi,target,testarget )

y=sim(net,input);
z=sim(net,testi);


corct=0;
for i=1:11200
    [a,b]=max(y(:,i));
    [a,c]=max(target(:,i));
    if b==c
        corct=corct+1;
    end
end
trainCCR=corct/i

corct=0;
for i=1:3200
    [a,b]=max(z(:,i));
    if b==testarget(i)
        corct=corct+1;
    end
end
testCCR=corct/i


end

