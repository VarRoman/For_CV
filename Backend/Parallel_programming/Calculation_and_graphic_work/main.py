# ІО-21 Безщасний Роман
# РГР, Варіант №2
# A = min(C) * Z + D * (MX * MR)

from mpi4py import MPI
import numpy as np
import time

# Start timer
start_time = time.time()

# MPI initialization
comm = MPI.COMM_WORLD
rank = comm.Get_rank()  # Thread number
N = 1000  # Array size
P = 4  # Number of threads

# Input of all variables
match rank:
    case 0:
        C = np.ones(N, dtype=int)
        Z = np.ones(N, dtype=int)

        comm.send(C, dest=1, tag=1)
        comm.send(Z, dest=1, tag=2)
        comm.send(C, dest=3, tag=1)
        comm.send(Z, dest=3, tag=2)

        MX = comm.recv(source=1, tag=3)
        MR = comm.recv(source=1, tag=4)
        D = comm.recv(source=1, tag=5)

    case 1:
        MX = np.ones((N, N), dtype=int)

        C = comm.recv(source=0, tag=1)
        Z = comm.recv(source=0, tag=2)

        MR = comm.recv(source=2, tag=4)
        D = comm.recv(source=2, tag=5)

        comm.send(C, dest=2, tag=1)
        comm.send(Z, dest=2, tag=2)
        comm.send(MX, dest=2, tag=3)

        comm.send(MX, dest=0, tag=3)
        comm.send(MR, dest=0, tag=4)
        comm.send(D, dest=0, tag=5)

    case 2:
        MR = np.ones((N, N), dtype=int)
        D = np.ones(N, dtype=int)

        comm.send(MR, dest=1, tag=4)
        comm.send(D, dest=1, tag=5)

        C = comm.recv(source=1, tag=1)
        Z = comm.recv(source=1, tag=2)
        MX = comm.recv(source=1, tag=3)

        comm.send(MX, dest=3, tag=3)
        comm.send(MR, dest=3, tag=4)
        comm.send(D, dest=3, tag=5)

    case 3:
        C = comm.recv(source=0, tag=1)
        Z = comm.recv(source=0, tag=2)
        MX = comm.recv(source=2, tag=3)
        MR = comm.recv(source=2, tag=4)
        D = comm.recv(source=2, tag=5)

# min(Ch)
Ch = np.array_split(C, P)
Ch = Ch[rank]
ai = min(Ch)

# min(a, ai)
match rank:
    case 0:
        comm.send(ai, dest=1, tag=7)

        a = comm.recv(source=1, tag=6)

    case 1:
        a1 = comm.recv(source=0, tag=7)

        comm.send(a1, dest=2, tag=7)
        comm.send(ai, dest=2, tag=8)

        a = comm.recv(source=2, tag=6)

        comm.send(a, dest=0, tag=6)

    case 2:
        a1 = comm.recv(source=1, tag=7)
        a2 = comm.recv(source=1, tag=8)
        a4 = comm.recv(source=3, tag=9)

        a = min(ai, a1, a2, a4)

        comm.send(a, dest=1, tag=6)
        comm.send(a, dest=3, tag=6)

    case 3:
        comm.send(ai, dest=2, tag=9)

        a = comm.recv(source=2, tag=6)

# Ah = а * Zh + D * (MX * MRh)
# Getting Zh
Zh = np.array_split(Z, P)
Zh = Zh[rank]
# Getting MRh
MRh = np.hsplit(MR, P)
MRh = MRh[rank]
# Getting the result - Ah
Ah = np.add(np.dot(a, Zh),
            np.dot(D, np.dot(MX, MRh)))

# Sending results to T2 for outputting results
match rank:
    case 0:
        comm.send(Ah, dest=1, tag=10)

    case 1:
        A1 = comm.recv(source=0, tag=10)
        A3 = comm.recv(source=2, tag=11)
        A4 = comm.recv(source=2, tag=12)
        temp = np.array([A1, Ah, A3, A4])
        res = temp.flatten()
        print('\nLength of output: ' + str(len(res)))
        if len(res) == 4:
            print(f'Output: {res}')
        else:
            print(f'Output: [{res[0]}, {res[1]}, {res[2]} ... {res[-1]}]')
        print(f'Execution time: ', (time.time() - start_time), '\n')

    case 2:
        A4 = comm.recv(source=3, tag=12)

        comm.send(Ah, dest=1, tag=11)
        comm.send(A4, dest=1, tag=12)

    case 3:
        comm.send(Ah, dest=2, tag=12)
