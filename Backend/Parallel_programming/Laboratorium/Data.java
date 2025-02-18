import java.util.Arrays;
import java.util.stream.IntStream;

public class Data {
    public static int N;
    public static int[] B;
    public static int[] Z;
    
    public static int[][] MM;
    public static int[][] MX;
    
    public static int[] Lh1;
    public static int[] Lh2;
    public static int[] Lh3;
    public static int[] Lh4;
    public static int[] Lh2_1;
    public static int[] Lh2_2;
    public static int[] X;
    
    //Функція для отримання частини вектора
    public static int[] fixArrayLength(int[] A, int start, int end) {
        int[] res = new int[end - start];
        IntStream.range(0, (end - start)).forEach(i -> res[i] = A[i]);

        return res;
    }
    
    // Функція, що повертає певну частину матриці
    public static int[][] fixMatrixLength(int[][] matrix, int start, int end) {
        int[][] res = new int[matrix.length][end - start];
        for (int i = 0; i < matrix.length; i++) {
            int ind = 0;
            for (int j = start; j < end; j++) {
                res[i][ind] = matrix[i][j];
                ind++;
            }
        }
        return res;
    }
    
    //Функція для множення матриць
    public static int[][] mulMatrix(int[][] vec1, int[][] vec2){
        int[][] result= new int[vec1.length][vec2[0].length];
        for (int i = 0; i < vec1.length; i++)
        {
            for (int j = 0; j < vec2[0].length; j++)
            {
                for (int k = 0; k < vec1[0].length; k++)
                {
                    result[i][j] += vec1[i][k] * vec2[k][j];
                }
            }
        }
        return result;
    }


    // Функція, що додає вектори
    public static int[] addArrays(int[] A, int[] B) {
        int[] res = new int[A.length];
        for (int i = 0; i < A.length; i++) {
            res[i] = A[i] + B[i];
        }
        return res;
    }

    // Функція, що множить вектор на матрицю
    static public int[] mulArrayMatrix(int[] A, int[][] matrix){
        int[] res = new int[matrix[0].length];
        for (int i = 0; i < matrix[0].length; i++) {
            for (int j = 0; j < A.length; j++) {
                res[i] += A[j] * matrix[j][i];
            }
        }
        return res;
    }

    // Функція, що вставляє вектор в частину іншого вектора
    public static void insertArrayRes(int[] A, int[] B, int start, int end) {
        int ind = 0;
        for (int i = start; i < end; i++) {
            B[i] = A[ind++];
        }
    }

    // Функція для множення скаляру на вектор
    public static int[] mulScalArray(int scal, int[] A) {
        IntStream.range(0, A.length).forEach(i -> A[i] *= scal);
        return A;
    }

    //Функція, що перемножує вектори між собою
    public static int mulArrays(int[] A, int[] B) {
        int res = 0;
        for (int i = 0; i < A.length; i++) {
            res += A[i] * B[i];
        }
        return res;
    }
    
    //Функція для виведення вектора
    public static void printvec(int[] VH){
        for (int j : VH) {
            System.out.print(j + " ");
        }
        System.out.println();
    }
    //Функція для початовго сортування
    public static int[] Sort(int[] vec1) {
        Arrays.sort(vec1);
        return vec1;
    }
    //Функція для сортування злиттям
    public static int[] sortTwoVecs(int[] vector1, int[] vector2) {
        int[] result = new int[vector1.length + vector2.length];
        for (int i = 0; i < result.length; i++) {
            if (i < vector1.length) {
                result[i] = vector1[i];
            }
            else {
                result[i] = vector2[i-vector1.length];
            }
        }
        Arrays.sort(result);
        return result;
    }
}