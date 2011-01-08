if(debug==1)
    [cost,grad]=icaCost(theta,Z,P);
    numgrad = computeNumericalGradient(@(w) icaCost(w,Z,P),theta);
    %disp([numgrad grad]);
    diff = norm(numgrad-grad)/norm(numgrad+grad);
    disp(diff);
    return;
end