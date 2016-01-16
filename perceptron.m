function output = perceptron(inputs, weights)

temp = weights(1)*1 + weights(2)*inputs(1) + weights(3)*inputs(2) + weights(4)*inputs(3) + weights(5)*inputs(4);

if temp > 0
    output = 2;
else
    output = 1;
end

end