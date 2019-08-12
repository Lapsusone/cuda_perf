make all

echo ""
echo "<<<"
./cuda_perf 100 1
echo ">>>"
echo ""

echo ""
echo "<<<"
./cuda_perf 4 32
echo ">>>"
echo ""

echo ""
echo "<<<"
./cuda_perf 10 10
echo ">>>"
echo ""

echo ""
echo "<<<"
./cuda_perf 100 64
echo ">>>"
echo ""

make clean
