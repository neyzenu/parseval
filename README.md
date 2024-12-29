# parseval
Parseval Teoremi - NASM Uygulaması
## Gereksinimler

- **NASM**: Assembler derleyicisi
- **GCC**: Linker olarak kullanmak için
- **Linux** veya benzeri Unix tabanlı bir işletim sistemi

## Kurulum

### 1. NASM ve GCC Kurulumu

Linux üzerinde NASM ve GCC kurmak için aşağıdaki komutları kullanabilirsiniz:

```bash
sudo apt update
sudo apt install nasm gcc


#!/bin/bash

# Derleme
nasm -f elf64 parseval.asm -o parseval.o

# Linkleme
gcc parseval.o -o parseval -no-pie

# Çalıştırma
./parseval

Zaman domeni enerji: 204
Frekans domeni enerji: 256

