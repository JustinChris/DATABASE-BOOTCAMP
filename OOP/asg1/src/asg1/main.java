package asg1;

import java.util.Scanner;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

public class main {

	static Collection<people> allPeople = new ArrayList<people>();
	
	public static void main(String[] args) {
		boolean keepGoing = true;
		
		while(keepGoing) {
			System.out.println("+======================+");
			System.out.println("+Options               +");
			System.out.println("+======================+");
			System.out.println("+1. Start Sharing      +");
			System.out.println("+2. update Participant +");
			System.out.println("+3. Delete Participant +");
			System.out.println("+4. Close App          +");
			System.out.println("+======================+");
			System.out.printf("Choice >> ");
			
			
			int choice;
			Scanner scan = new Scanner(System.in);
			choice = scan.nextInt();
			scan.nextLine();
			
			switch(choice) {
			case 1: start(); break;
			case 2: update(); break;
			case 3: delete(); break;
			case 4: 
				close();
				keepGoing = false;
				break;
			}
		}
	}
	
	public static void start() {
		int shareNumber;
		String shareUsername;
		Scanner inp = new Scanner(System.in);
		
		do {
			System.out.printf("Input a number [0 - 100]: ");
			shareNumber = inp.nextInt();
			inp.nextLine();
		}while (shareNumber <= 0 || shareNumber >= 100);
		
		do {
			System.out.println("Could you give me your username [5 - 20 characters]? ");
			shareUsername = inp.nextLine();
			inp.nextLine();
		}while(shareUsername.length() < 5 || shareUsername.length() > 20 && checkUsername());
		
		people p1 = new people(shareUsername,shareNumber);
		
		allPeople.add(p1);

		System.out.println("You are the " + allPeople.size() + " that joins the game");
		System.out.println("You share number: " + shareNumber);
	}
	
	public static void update() {
		System.out.println("+===========================================+");
		System.out.println("+ Share List                                +");
		System.out.println("+===========================================+");
		int total = 0;
		for(Iterator i = allPeople.iterator(); i.hasNext();) {
			total += 1;
			System.out.printf("|%-3d |%-20s |\n", total, i.next() );
		}
	}
	
	public static void delete() {
		
	}
	
	public static void close() {
		
	}
	
	public static boolean checkUsername() {
		return true;
	}
}
