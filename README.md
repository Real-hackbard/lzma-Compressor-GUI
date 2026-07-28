# :computer: lzma-Compressor-GUI


</br>

![Compiler](https://github.com/user-attachments/assets/a916143d-3f1b-4e1f-b1e0-1067ef9e0401) ![10 Seattle](https://github.com/user-attachments/assets/c70b7f21-688a-4239-87c9-9a03a8ff25ab) ![10 1 Berlin](https://github.com/user-attachments/assets/bdcd48fc-9f09-4830-b82e-d38c20492362) ![10 2 Tokyo](https://github.com/user-attachments/assets/5bdb9f86-7f44-4f7e-aed2-dd08de170bd5) ![10 3 Rio](https://github.com/user-attachments/assets/e7d09817-54b6-4d71-a373-22ee179cd49c)  ![10 4 Sydney](https://github.com/user-attachments/assets/e75342ca-1e24-4a7e-8fe3-ce22f307d881) ![11 Alexandria](https://github.com/user-attachments/assets/64f150d0-286a-4edd-acab-9f77f92d68ad) ![12 Athens](https://github.com/user-attachments/assets/59700807-6abf-4e6d-9439-5dc70fc0ceca)  
![Components](https://github.com/user-attachments/assets/d6a7a7a4-f10e-4df1-9c4f-b4a1a8db7f0e) ![None](https://github.com/user-attachments/assets/30ebe930-c928-4aaf-a8e1-5f68ec1ff349)  
![Description](https://github.com/user-attachments/assets/dbf330e0-633c-4b31-a0ef-b1edb9ed5aa7) <img src="https://github.com/user-attachments/assets/9bfebba5-0593-42cf-a44c-d7eaf164318d" />  
![Last Update](https://github.com/user-attachments/assets/e1d05f21-2a01-4ecf-94f3-b7bdff4d44dd) ![042026](https://github.com/user-attachments/assets/2446b1e1-a732-4080-97bc-11906d6ff389)  
![License](https://github.com/user-attachments/assets/ff71a38b-8813-4a79-8774-09a2f3893b48) ![Freeware](https://github.com/user-attachments/assets/1fea2bbf-b296-4152-badd-e1cdae115c43)  

</br>

LZMA (Lempel–Ziv–Markov chain algorithm) is a [lossless data compression](https://en.wikipedia.org/wiki/Lossless_compression) algorithm developed since 1998 by Igor Pavlov, the developer of 7-Zip. It has been used in the [7z](https://en.wikipedia.org/wiki/7z) format of the [7-Zip](https://en.wikipedia.org/wiki/7-Zip) archiver since 2001. This algorithm uses a [dictionary compression](https://en.wikipedia.org/wiki/Dictionary_coder) scheme somewhat similar to the LZ77 algorithm published by Abraham Lempel and Jacob Ziv in 1977 and features a high compression ratio (generally higher than bzip2) and a variable compression-dictionary size (up to 4 GB), while still maintaining decompression speed similar to other commonly used compression algorithms.

</br>

<img src="https://github.com/user-attachments/assets/df6e9287-d74a-4db6-92bb-65cfeed139a4" />

</br>
</br>

LZMA files can be either streamed or non-streamed.  Non-streamed  files are  created  only when the size of the file being compressed is known. In practice this means that the source file must be a regular file.  In other  words,  if  compressing  from the standard input or from a named pipe (fifo) the compressed file will always be streamed.

Both streamed and non-streamed files are  compressed  identically;  the only  differences  are  found from the beginnings and ends of LZMA compressed files: Non-streamed files contain the uncompressed size of  the file  in  the  LZMA  file header; streamed files have uncompressed size marked as unknown. To know where to stop decoding, streamed files  have a  special  End  Of  Stream marker at the end of the LZMA file. The EOS marker makes streamed files five or six bytes bigger than non-streamed.

# :wrench: Parameters:
Compress or uncompress FILE (by default, compress FILE in-place).

```txt
       NAME
       lzma, unlzma, lzcat - LZMA compression and decompression tool

SYNOPSIS
       lzma [-123456789cdefhkLqtvV] [-S suffix] [filenames ...]
       unlzma [-cfhkLqtvV] [-S suffix] [filenames ...]
       lzcat [-fhLqV] [filenames ...]

       Short options can be grouped like -cd.

       -c --stdout --to-stdout
              The output is written to the standard output. The original files
              are  kept  unchanged.  When  compressing  to the standard output
              there can be only one input file. This option  is  implied  when
              input  is  read from the standard input or the script is invoked
              as lzcat.

       -d --decompress --uncompress
              Force decompression regardless of the invocation name. This  the
              default when called as unlzma or lzcat.

       -f --force
              Force compression or decompression even if source file is a sym-
              link, target exists, or target is a  terminal.  In  contrast  to
              gzip  and  bzip2,  if  input data is not in LZMA format, --force
              does not make lzma behave like cat.  lzma never prompts if  tar-
              get  file  should be overwritten; existing files are skipped or,
              in case of --force, overwritten.

       -h --help
              Show a summary of supported options and quit.

       -k --keep
              Do not delete the input files after  compression  or  decompres-
              sion.

       -L --license
              Show licensing information of lzma.

       -q --quiet
              Suppress  all  warnings.  You can still check the exit status to
              detect if a warning had been shown.

       -S --suffix .suf
              Use .suf instead of the default .lzma.  A null suffix forces un-
              lzma  to  decompress all the given files regardless of the file-
              name suffix.

       -t --test
              Check the integrity of the compressed file(s). Without --verbose
              no output is produced if no errors are found.

       -v --verbose
              Show  the  filename  and  percentage reduction of each processes
              file.

       -V --version
              Show the version number of lzma.

       -z --compress
              Force compression regardless of the invocation name.

       -1 .. -9
              Set the compression ratio. These options have no effect when de-
              compressing.

       --fast Alias to -1.

       --best Alias to -9.

```

</br>
