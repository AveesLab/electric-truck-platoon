classdef LSTMStatefulPredictor < matlab.System & ...
    matlab.system.mixin.Propagates

    properties (Access = private)
        net
        initialized = false;
    end

    methods (Access = protected)

        function setupImpl(obj)
            obj.net = coder.loadDeepLearningNetwork( ...
                'pretrainedBSOCNetworkCompressed.mat', 'dlnetwork');
            obj.initialized = true;
        end

        function y = stepImpl(obj, x)
            % x: [3x1] 입력값 → [3x1x1] reshape
            % reshape 시 row-major 문제 방지
            input = reshape(x(:), [3,1,1]);  
            dlX = dlarray(input, 'CBT');

            % 추론
            [dlY, newState] = predict(obj.net, dlX);

            % 상태 갱신
            obj.net.State = newState;

            y = extractdata(dlY);
        end

        %% Simulink가 입출력 정의 파악하도록 도와주는 메서드들
        function sz = getOutputSizeImpl(~)
            sz = [1,1];
        end

        function dt = getOutputDataTypeImpl(~)
            dt = "double";
        end

        function cp = isOutputComplexImpl(~)
            cp = false;
        end

        function fr = isOutputFixedSizeImpl(~)
            fr = true;
        end
    end
end
