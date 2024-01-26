let fibonacci: use n as
    if n < 2 ? return n;
    ,,
    return fibonacci(n - 2) + fibonacci(n - 1);
,,

let #idx : 1;

while #idx < 20 ?
    print fibonacci(#idx);
    #idx += 1;
,,
