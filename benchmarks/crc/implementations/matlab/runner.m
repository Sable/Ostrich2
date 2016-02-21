function runner(page_size,num_pages,num_execs)
% Example: runner(65536,128,1);
if mod(page_size, 8) ~= 0
    error('Unsupported page size of %u, please choose a page size that is a multiple of 8\n',page_size);
end

s = RandStream('mcg16807','Seed',49734321);
% RandStream.setDefaultStream(s);
RandStream.setGlobalStream(s);
seed = 10000;

h_num = randi(seed, num_pages, page_size); %rand_crc
expected_crc = 2231263667;

fileID = fopen('Lut.data', 'r');
crc32Lookup = reshape(fscanf(fileID,'%x'),8,256);
fclose(fileID);

tic
for j = 1:num_execs
    final_crc = crc_ostrich(page_size,num_pages,h_num,crc32Lookup);
    if and(page_size == 65536, num_pages == 128)
        if final_crc ~= expected_crc
            error('Invalid crc check, received %u while expecting %u\n', final_crc, expected_crc);
        end
    end
end
elapsedTime = toc;

if not(and(page_size == 65536, num_pages == 128))
    warning('WARNING: no self-checking step for page_size %u and num_pages %u\n', page_size, num_pages);
end

fprintf('{ \"status\": %d, \"options\": \"-n %d -s %d -r %d\", \"time\": %f }\n', 1, num_pages, page_size, num_execs, elapsedTime);

end