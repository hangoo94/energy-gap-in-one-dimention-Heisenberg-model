function save_to_file(N, do_pbc, do_negative)
  if N == 0
    for i = 2:1:16
      save_to_file(i, do_pbc, do_negative)
    end
    return
  end
  if do_pbc && ~do_negative
    data_file = 'data_pbc.csv';
  elseif do_negative && ~do_pbc
    data_file = 'data_negative.csv';
  elseif do_pbc && do_negative
      data_file = 'data_negative_pbc.csv';
  else
    data_file = 'data.csv';
  end
  prev_data = [];
  if isfile(data_file)
    prev_data = csvread(data_file);
  end
  [H, E, d] = hamiltonian(N, do_pbc, do_negative);
  r = size(prev_data, 1);
  new_data = [];
  for i = 1:1:r+1
    if i == r+1 || prev_data(i, 1) > N
      new_data = [prev_data(1:i-1, :); [N, d]; prev_data(i:end, :)];
      break
    elseif prev_data(i, 1) == N
      new_data = [prev_data(1:i-1, :); [N, d]; prev_data(i+1:end, :)];
      break
    end
      
  end
  csvwrite(data_file, new_data);
end