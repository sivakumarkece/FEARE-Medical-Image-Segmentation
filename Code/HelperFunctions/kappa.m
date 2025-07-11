function k = kappa(Img)
    [Model_G_X, Model_G_Y] = gradient(Img);
    Norm = sqrt(Model_G_X.^2 + Model_G_Y.^2 + eps);
    Model_NG_X = Model_G_X ./ Norm;
    Model_NG_Y = Model_G_Y ./ Norm;
    [Model_G_XX, ~] = gradient(Model_NG_X);
    [~, Model_G_YY] = gradient(Model_NG_Y);
    k = Model_G_XX + Model_G_YY;
end
