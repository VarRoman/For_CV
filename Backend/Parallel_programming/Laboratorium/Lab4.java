/*
Лабораторна робота №4 Варіант 23
𝑋 = 𝑠𝑜𝑟𝑡(𝑑 ∗ 𝐵 + 𝑍 ∗ (𝑀𝑀 ∗ 𝑀𝑋)) ∗ min(𝐵)
T1:
T2: B, MX
T3: 
T4: X, MM, d, Z
Безщасний Роман ІО-21
Дата 22.12.2024
*/

import java.util.Scanner;

public class Lab4 {
    public static void main(String[] args) {

        Monitor monitor = new Monitor();
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter the size of the matrices:");
        Data.N = scanner.nextInt();
        T1 T1 = new T1(monitor);
        T2 T2 = new T2(monitor);
        T3 T3 = new T3(monitor);
        T4 T4 = new T4(monitor);
        long startTime = System.currentTimeMillis();
        T1.start();
        T2.start();
        T3.start();
        T4.start();
        try {
            T1.join();
            T2.join();
            T3.join();
            T4.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        long endTime = System.currentTimeMillis();
        long duration = (endTime - startTime);
        System.out.println("Execution time in milliseconds:"+duration);
    }
}