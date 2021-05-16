package main;

import java.util.Scanner;

public class main {

	public static void main(String[] args) {
		System.out.println("============");
		System.out.println("BJ - JPTable");
		System.out.println("============");
		boolean keepGoing = true;
		Scanner scan = new Scanner(System.in);
		while (keepGoing) {
			System.out.println("1. Start The Simulation!!");
			System.out.println("2. Close App");
			System.out.print("Choice >> ");
			Integer firstNum;
			int firstNumint;
			Integer secondNum;
			int secondNumint;
			Integer choice = scan.nextInt();
			scan.nextLine();
			switch(choice) {
			case 1:
				
				do {
					System.out.print("Input the first number [1 - 100](inclusive): ");
					firstNum = scan.nextInt();
					firstNumint = firstNum;
					scan.nextLine();
				}while(firstNum <= 0 || firstNum >= 100);
				
				do {
					System.out.print("Input the second number [1 - 100](inclusive): ");
					secondNum = scan.nextInt();
					secondNumint = secondNum;
					scan.nextLine();
				}while (secondNum <= 0 || secondNum >= 100);
				
				String strType = firstNum.toString()+ " + " + secondNum.toString();
				Integer kaliType = firstNum * secondNum;
				float bagiType = firstNumint / secondNumint;
				
				System.out.println("+=========================================================================================================================+");
				System.out.println("+  + (String type)  |  (Character Type)  |  * (Integer type)  |  / (Floating Type)  |  input 1 == input 2 (Boolean Type)  +");
				System.out.println("+=========================================================================================================================+");
				System.out.printf("+ %8s | %-9c %-9c | %-20d | %-20f | %-20b |\n",strType, firstNum, secondNum, kaliType, bagiType, firstNum == secondNum);
				
				String p1String;
				String p2String;
				
				boolean p1bool;
				boolean p2bool;
				
				do {
					System.out.printf("Give me value for p1 [true | false]: ");
					p1String = scan.nextLine();
				}while(p1String != "true" || p1String != "false");
				
				do {
					System.out.printf("Give me value for p2 [true | false]: ");
					p2String = scan.nextLine();
				}while(p2String != "true" || p2String != "false");
				
				if (p1String == "true") {
					p1bool = true;
				}else if (p1String == "false") {
					p1bool = false;
				}
				
				if (p2String == "true") {
					p2bool = true;
				}else if (p2String == "false") {
					p2bool = false;
				}
				
				
				
				break;
			case 2:
				System.out.println("Thank you");
				keepGoing = false;
				break;
			default:
				break;
			}
		}
	}

}
