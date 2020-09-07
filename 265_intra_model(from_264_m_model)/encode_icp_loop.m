function bits = encode_icp_loop(icp_loop)

    % ind1 = [16	15	14	13	12	11	10	9	8	7	6	5	4	3	2	1	1	2	3	4	5	6	7	8	1	9	2	3	10	4	5	11	6	1	2	7	3	12	8	4	1	5	9	2	6	3	13	10	7	4	1	2	5	8	3	11	6	1	4	9	2	7	5	3	1	14	12	10	8	6	4	2	1	3	5	7	9	2	4	11	6	1	3	8	5	2	13	10	7	4	1	3	6	9	2	5	1	12	8	4	3	7	2	11	6	1	5	10	4	3	9	2	1	8	7	6	5	4	3	2	1	5	3	15	14	13	12	11	10	9	8	7	6	4	2	1	1	2	3	4	5	6	7	8	1	9	2	3	10	4	5	11	6	1	2	7	3	12	8	4	1	5	9	2	6	3	13	10	7	4	1	2	5	8	3	11	6	1	4	9	2	7	5	3	1	14	12	10	8	6	4	2	1	3	5	7	9	2	4	11	6	1	3	8	5	2	13	10	7	4	1	3	6	9	2	5	1	12	8	4	3	7	2	11	6	1	5	10	4	3	9	2	1	8	7	6	5	4	3	2	1	5	3	15	14	13	12	11	10	9	8	7	6	4	2	1];
    % ind2 = [1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	2	2	2	2	2	2	2	2	3	2	3	3	2	3	3	2	3	4	4	3	4	2	3	4	5	4	3	5	4	5	2	3	4	5	6	6	5	4	6	3	5	7	6	4	7	5	6	7	8	2	3	4	5	6	7	8	9	8	7	6	5	9	8	4	7	10	9	6	8	10	3	5	7	9	11	10	8	6	11	9	12	4	7	10	11	8	12	5	9	13	10	6	11	12	7	13	14	8	9	10	11	12	13	14	15	12	14	2	3	4	5	6	7	8	9	10	11	13	15	16	17	16	15	14	13	12	11	10	18	9	17	16	8	15	14	7	13	19	18	12	17	6	11	16	20	15	10	19	14	18	5	9	13	17	21	20	16	12	19	8	15	22	18	11	21	14	17	20	23	4	7	10	13	16	19	22	24	21	18	15	12	23	20	9	17	25	22	14	19	24	6	11	16	21	26	23	18	13	25	20	27	8	15	22	24	17	26	10	19	28	21	12	23	25	14	27	29	16	18	20	22	24	26	28	30	23	27	3	5	7	9	11	13	15	17	19	21	25	29	31];
    ind1 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 1 2 3 4 5 6 7 8 1 2 9 3 4 10 5 1 6 11 2 7 3 4 8 12 1 5 2 9 6 3 1 4 7 10 13 2 5 8 3 1 6 11 4 2 9 7 5 3 1 2 4 6 8 10 12 14 1 3 5 7 2 9 4 1 6 11 3 8 5 2 1 4 7 10 13 3 6 2 9 5 1 4 8 12 3 7 2 1 6 11 5 4 10 3 2 9 1 8 7 6 5 4 3 2 1 3 5 1 2 4 6 7 8 9 10 11 12 13 14 15 1 2 3 4 5 6 7 8 1 2 9 3 4 10 5 1 6 11 2 7 3 4 8 12 1 5 2 9 6 3 1 4 7 10 13 2 5 8 3 1 6 11 4 2 9 7 5 3 1 2 4 6 8 10 12 14 1 3 5 7 2 9 4 1 6 11 3 8 5 2 1 4 7 10 13 3 6 2 9 5 1 4 8 12 3 7 2 1 6 11 5 4 10 3 2 9 1 8 7 6 5 4 3 2 1 3 5 1 2 4 6 7 8 9 10 11 12 13 14 15];
    ind2 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 3 3 2 3 3 2 3 4 3 2 4 3 4 4 3 2 5 4 5 3 4 5 6 5 4 3 2 6 5 4 6 7 5 3 6 7 4 5 6 7 8 8 7 6 5 4 3 2 9 8 7 6 9 5 8 10 7 4 9 6 8 10 11 9 7 5 3 10 8 11 6 9 12 10 7 4 11 8 12 13 9 5 10 11 6 12 13 7 14 8 9 10 11 12 13 14 15 14 12 16 15 13 11 10 9 8 7 6 5 4 3 2 17 16 15 14 13 12 11 10 18 17 9 16 15 8 14 19 13 7 18 12 17 16 11 6 20 15 19 10 14 18 21 17 13 9 5 20 16 12 19 22 15 8 18 21 11 14 17 20 23 22 19 16 13 10 7 4 24 21 18 15 23 12 20 25 17 9 22 14 19 24 26 21 16 11 6 23 18 25 13 20 27 22 15 8 24 17 26 28 19 10 21 23 12 25 27 14 29 16 18 20 22 24 26 28 30 27 23 31 29 25 21 19 17 15 13 11 9 7 5 3];
    % ind1_nx = [16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 1 2 3 4 5 6 7 8 1 9 2 3 10 4 5 11 6 1 2 7 12 3 8 4 1 5 9 2 13 6 3 10 7 4 1 2 5 8 11 3 6 1 14 9 4 2 7 5 12 3 1 10 8 6 4 2 1 3 5 7 9 11 2 4 13 6 1 8 3 5 10 2 7 4 1 15 12 9 6 3 2 5 8 1 4 11 7 3 2 6 10 1 5 14 9 4 3 8 2 1 7 13 6 5 4 12 3 2 1 11 10 9 8 7 6 5 4 3 2 1 1 2 3 4 5 6 7 8 9 10 11 1 2 12 3 4 5 13 6 7 1 2 8 3 9 4 14 5 1 10 6 2 3 7 11 4 1 8 5 2 15 12 9 6 3 1 4 7 2 10 5 3 8 1 13 6 4 2 11 9 7 5 3 1 2 4 6 8 10 1 12 3 5 7 2 14 9 4 1 6 3 11 8 5 2 1 4 7 10 3 13 6 2 9 5 1 4 8 12 3 7 2 1 6 11 5 4 10 3 2 9 1 8 7 6 5 4 3 2 1];按频率排

    % ind2_nx = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 3 2 3 3 2 3 3 2 3 4 4 3 2 4 3 4 5 4 3 5 2 4 5 3 4 5 6 6 5 4 3 6 5 7 2 4 6 7 5 6 3 7 8 4 5 6 7 8 9 8 7 6 5 4 9 8 3 7 10 6 9 8 5 10 7 9 11 2 4 6 8 10 11 9 7 12 10 5 8 11 12 9 6 13 10 3 7 11 12 8 13 14 9 4 10 11 12 5 13 14 15 6 7 8 9 10 11 12 13 14 15 16 17 16 15 14 13 12 11 10 9 8 7 18 17 6 16 15 14 5 13 12 19 18 11 17 10 16 4 15 20 9 14 19 18 13 8 17 21 12 16 20 3 7 11 15 19 22 18 14 21 10 17 20 13 23 6 16 19 22 9 12 15 18 21 24 23 20 17 14 11 25 8 22 19 16 24 5 13 21 26 18 23 10 15 20 25 27 22 17 12 24 7 19 26 14 21 28 23 16 9 25 18 27 29 20 11 22 24 13 26 28 15 30 17 19 21 23 25 27 29 31];按频率排

    % ind1 = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 1 2 3 4 5 6 7 8 1 9 2 3 10 4 5 11 6 1 2 7 3 12 8 4 1 5 9 2 6 13 3 10 7 4 1 2 5 8 11 3 6 1 4 9 14 2 7 5 3 12 1 10 8 6 4 2 1 3 5 7 9 11 2 4 6 13 1 8 3 5 10 2 7 4 1 3 6 9 12 15 2 5 8 1 4 11 7 3 2 6 10 1 5 4 9 14 3 8 2 1 7 6 13 5 4 3 12 2 1 11 10 9 8 7 6 5 4 3 2 1 1 2 3 4 5 6 7 8 9 10 11 1 2 3 12 4 5 6 13 7 1 2 8 3 4 9 14 5 1 10 6 2 3 7 11 4 1 8 5 2 3 6 9 12 15 1 4 7 2 10 5 3 8 1 6 13 4 2 11 9 7 5 3 1 2 4 6 8 10 1 3 12 5 7 2 4 9 14 1 6 3 11 8 5 2 1 4 7 10 3 6 13 2 9 5 1 4 8 3 12 7 2 1 6 11 5 4 10 3 2 9 1 8 7 6 5 4 3 2 1]; 按频率排
    % ind2 = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 3 2 3 3 2 3 3 2 3 4 4 3 4 2 3 4 5 4 3 5 4 2 5 3 4 5 6 6 5 4 3 6 5 7 6 4 2 7 5 6 7 3 8 4 5 6 7 8 9 8 7 6 5 4 9 8 7 3 10 6 9 8 5 10 7 9 11 10 8 6 4 2 11 9 7 12 10 5 8 11 12 9 6 13 10 11 7 3 12 8 13 14 9 10 4 11 12 13 5 14 15 6 7 8 9 10 11 12 13 14 15 16 17 16 15 14 13 12 11 10 9 8 7 18 17 16 6 15 14 13 5 12 19 18 11 17 16 10 4 15 20 9 14 19 18 13 8 17 21 12 16 20 19 15 11 7 3 22 18 14 21 10 17 20 13 23 16 6 19 22 9 12 15 18 21 24 23 20 17 14 11 25 22 8 19 16 24 21 13 5 26 18 23 10 15 20 25 27 22 17 12 24 19 7 26 14 21 28 23 16 25 9 18 27 29 20 11 22 24 13 26 28 15 30 17 19 21 23 25 27 29 31]; 按频率排

    icp_sort = nan(1, 256);
    for n = 1:256
        icp_sort(n) = icp_loop(ind1(n), ind2(n));
        % icp_sort(n) = icp_loop(ind1_nx(n), ind2_nx(n));
    end
    bits = huffman(icp_sort);
end
