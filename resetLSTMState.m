function net = resetLSTMState(net, inputSize)
    dummy = dlarray(zeros(inputSize,1,1), 'CBT');
    [~, state] = predict(net, dummy);
    state.Value(:) = {[]};
    net.State = state;
end
