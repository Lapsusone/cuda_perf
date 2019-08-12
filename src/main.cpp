#include <iostream>
#include <iomanip>
#include <chrono>
#include <thread>

#include "solver/parallel.cuh"

void usage();
void command(int argc, char* argv[]);

long run_cuda(int n_block, int n_thread);
void printStatistics(long runtime);

using namespace std::chrono;

using std::cout;
using std::endl;
using std::flush;
using std::setprecision;
using std::setw;
using std::stod;
using std::stoi;

int main(int argc, char* argv[]) {
    // Timing variables.
    long runtime = 0;

    if(3 != argc) {
        usage();
        return EXIT_FAILURE;
    }
    int n_block = stoi(argv[1], nullptr, 10);
    int n_thread = stoi(argv[2], nullptr, 10);

    command(argc, argv);

    runtime = run_cuda(n_block, n_thread);

    printStatistics(runtime);

    return EXIT_SUCCESS;
}

void usage() {
    cout << "Invalid arguments." << endl << flush;
    cout << "Arguments: blocks threads" << endl << flush;
}

void command(int argc, char* argv[]) {
    cout << "Command:" << flush;

    for(int i = 0; i < argc; i++) {
        cout << " " << argv[i] << flush;
    }

    cout << endl << flush;
}

long run_cuda(int n_block, int n_thread) {
    time_point<high_resolution_clock> timepoint_s = high_resolution_clock::now();
    plus100(n_block, n_thread);
    time_point<high_resolution_clock> timepoint_e = high_resolution_clock::now();

    return duration_cast<microseconds>(timepoint_e - timepoint_s).count();
}

void printStatistics(long runtime) {
    cout << "Runtime: " << runtime / 1000000.0 << " seconds" << endl << flush;
}
