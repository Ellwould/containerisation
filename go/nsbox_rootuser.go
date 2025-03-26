// Package clause main, to make sure the source code is executed directly
package main

// Import statement to get other packages needed in this program
import (
	"fmt"
	"os"
	"os/exec"
	"runtime"
	"strconv"
	"strings"
	"syscall"
)

// Background space width integer constant
const bgWidth int = 54

// Option title name string constants
const opt1Name, opt2Name, opt3Name, opt4Name, opt5Name, opt6Name string = "Run Container",
	"NOT IN USE",
	"NOT IN USE",
	"NOT IN USE",
	"NOT IN USE",
	"Exit nsbox"

// American National Standards Institute (ANSI) reset colour code
var resetColour = "\033[0m"

// American National Standards Institute (ANSI) text colour codes
var textRed = "\033[31m"
var textGreen = "\033[32m"
var textYellow = "\033[33m"
var textBlue = "\033[34m"
var textMagenta = "\033[35m"
var textCyan = "\033[36m"
var textWhite = "\033[37m"
var textBoldWhite = "\033[1;37m"
var textBlack = "\033[30m"
var textBoldBlack = "\033[1;30m"

// American National Standards Institute (ANSI) background colour codes
var bgRed = "\033[41m"
var bgGreen = "\033[42m"
var bgYellow = "\033[43m"
var bgBlue = "\033[44m"
var bgPurple = "\033[45m"
var bgCyan = "\033[46m"
var bgWhite = "\033[47m"
var bgBlack = "\033[40m"

// Clear screen function for GNU/Linux OS's
func clearScreen() {
	fmt.Print("\033[H\033[2J")
}

// Function to inform the user to press enter/return to continue
func continueButton() {
	fmt.Println("   " + textBoldBlack + "Press the enter/return button to continue..." + resetColour)
	fmt.Scanln()
	// Run main menu function
	mainMenu()
}

// Function to create option titles in the main menu function
func optTitle(title string, textColour string, bgColour string) {
	boarderSpace := strings.Repeat(" ", len(title)*3)
	titleSpace := strings.Repeat(" ", len(title))
	clearScreen()
	fmt.Println("  " + bgColour + boarderSpace + resetColour)
	fmt.Println("  " + bgColour + textBoldWhite + titleSpace + title + titleSpace + resetColour)
	fmt.Println("  " + bgColour + boarderSpace + resetColour)
	fmt.Println("")
}

// Function to create white background space based on a integer
func background(numberSpaces int) {
	fmt.Println(bgWhite, strings.Repeat(" ", numberSpaces), resetColour)
}

// Option 1 function
func opt1() {
	// Bash shell to be executed
	shellCmd := exec.Command("/bin/bash")
	// Standard in, out and error
	shellCmd.Stdin = os.Stdin
	shellCmd.Stdout = os.Stdout
	shellCmd.Stderr = os.Stderr
	// Clone the namespaces inside the Linux kernel via system calls
	shellCmd.SysProcAttr = &syscall.SysProcAttr{
		Cloneflags: syscall.CLONE_NEWNS | syscall.CLONE_NEWUTS | syscall.CLONE_NEWIPC | syscall.CLONE_NEWPID | syscall.CLONE_NEWNET | syscall.CLONE_NEWCGROUP | syscall.CLONE_NEWTIME,
	}
	// Variable for nsbox PID (Processor IDentification) that also converts it in to data type string
	nsboxPid := strconv.Itoa(os.Getpid())
	fmt.Println("  "+bgGreen+textBoldWhite, " nsbox running as user:", os.Getuid(), "as PID:", nsboxPid, resetColour)
	// Run pivot root function
	opt1PivotRoot()
	fmt.Println("")
	shellCmd.Run()
}

// Option 1 function for pivot root on container
func opt1PivotRoot() {
	// Variable for container Processor IDentification (PID) that also converts it in to a string
	containerPid := strconv.Itoa(os.Getpid())
	fmt.Println("")
	fmt.Println("  "+bgGreen+textBoldWhite, " Container User ID:", os.Getuid(), "as PID:", containerPid, resetColour)
	// Chroot used while devolping, will change to pivot root later
	syscall.Chroot("/container/container1")
	// Change directory to root
	os.Chdir("/")
}

// // Option 2 function (Future use)
func opt2() {
}

// Main menu function to select options
func mainMenu() {
	// Clears the screen on GNU/Linux
	clearScreen()
	fmt.Println("")
	background(bgWidth)
	fmt.Print(bgWhite + textBoldBlack + "   " + "nsbox (namespace box) v1.0" + resetColour)
	background(25)
	background(bgWidth)
	fmt.Println(bgWhite + textBoldBlack + "   " + "Please select a number from the following options    " + resetColour)
	background(bgWidth)
	background(bgWidth)

	// String array of options for main menu
	option := []string{
		bgCyan + " " + opt1Name + "         ",
		bgBlue + " " + opt2Name + "            ",
		bgPurple + " " + opt3Name + "            ",
		bgYellow + " " + opt4Name + "            ",
		bgBlack + " " + opt5Name + "            ",
		bgRed + " " + opt6Name + "            "}
	// A loop to print string array options
	for index, value := range option {
		fmt.Print(bgWhite+textBoldWhite+"  ", value, "[", index+1, "] ", resetColour)
		background(25)
		background(bgWidth)
	}

	fmt.Println("")
	fmt.Print(textBoldBlack + "   Please enter an option: ")
	// User input of option
	var input string
	fmt.Scan(&input)
	fmt.Println("" + resetColour)

	// Conditional statement for option selected
	if input == "1" {
		// Option 1 to run container
		optTitle(opt1Name, textBoldWhite, bgCyan)
		opt1()
	} else if input == "2" {
		// Option 2
		optTitle(opt2Name, textBoldWhite, bgBlue)
		//opt2()
		continueButton()
	} else if input == "6" || input == "exit" {
		optTitle("Exited nsbox", textBoldWhite, bgRed)
		os.Exit(0)
	} else {
		// Display message telling user input needs to be a number from 1 to 6
		background(bgWidth)
		fmt.Print(bgWhite+"        "+resetColour+bgRed+textBoldWhite+" The input must be a number between 1-", len(option), " "+resetColour)
		background(6)
		background(bgWidth)
		fmt.Println("")
		continueButton()
	}
}

// Main function
func main() {
	// Check if OS is GNU/Linux
	if runtime.GOOS != "linux" {
		fmt.Println("Operating system must be GNU/Linux to work")
	} else {
		// Run main menu function
		mainMenu()
	}
}
