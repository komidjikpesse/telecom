function [results] = run_simulation(param)
%RUN_SIMULATION Run the simulation of all blocks

%% Source
%results.message = param.source.sequence;
results.message = source(param);


%% Source encoding
results.u = source_encoding(param,results.message);
if param.source.cardinality > 0
    results.compression_factor = ...
        (length(results.message)*ceil(log2(param.source.cardinality))) / ...
        (length(results.u));
else
    results.compression_factor = 0;
end

results.u_ber = 0;


results.u_hat = results.u;
% Source decoding
results.message_hat = source_decoding(param,results.u_hat);


min_len = min(length(results.message_hat),length(results.message));
results.end_to_end_ser = sum(results.message_hat(1:min_len) ~= results.message(1:min_len))/min_len;





end

