close all
clc
syms n
f=0.5.^n+(1/3).^n;
Fz=ztrans(f)
pretty(Fz)