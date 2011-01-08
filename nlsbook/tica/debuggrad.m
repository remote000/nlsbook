if(debug==1)
    [cost,grad]=ticaCost(theta,Z,P);
    numgrad = computeNumericalGradient(@(w) ticaCost(w,Z,P),theta);
    %disp([numgrad grad]);
    diff = norm(numgrad-grad)/norm(numgrad+grad);
    disp(diff);
    return;
end