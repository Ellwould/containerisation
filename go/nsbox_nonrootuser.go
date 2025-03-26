package main

import (
	"fmt"
	"os"
	"os/exec"
	"runtime"
	"strconv"
	"strings"
	"syscall"
)

// Background space width constant
const bgWidth int = 54

// Option title names constant
const opt1Name, opt2Name, opt3Name, opt4Name, opt5Name, opt6Name string = "Run Container",
	"NOT IN USE",
	"NOT IN USE",
	"NOT IN USE",
	"NOT IN USE",
	"Exit nsbox"

// American National Standards Institute (ANSI) reset colour code
var resetColour = "\033[0m"

// American National Standards Institute (ANSI) text colour codess
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

// Clear Screen Function for GNU/Linux
func clearScreen() {
	fmt.Print("\033[H\033[2J")
}

// Function to inform the user to press enter/return to continue
func continueButton() {
	fmt.Println("   " + textBoldBlack + "Press the enter/return button to continue..." + resetColour)
	fmt.Scanln()
	mainMenu()
}

// Function to create option titles in the mainMenu function
func optTitle(title string, textColour string, bgColour string) {
	boarderSpace := strings.Repeat(" ", len(title)*3)
	titleSpace := strings.Repeat(" ", len(title))
	clearScreen()
	fmt.Println("  " + bgColour + boarderSpace + resetColour)
	fmt.Println("  " + bgColour + textBoldWhite + titleSpace + title + titleSpace + resetColour)
	fmt.Println("  " + bgColour + boarderSpace + resetColour)
	fmt.Println("")
}

// Function to create space based on a number
func background(numberSpaces int) {
	fmt.Println(bgWhite, strings.Repeat(" ", numberSpaces), resetColour)
}

func opt1() {
	// Bash shell to be executed
	shellCmd := exec.Command("/bin/bash")
	// Standard in, out and error
	shellCmd.Stdin = os.Stdin
	shellCmd.Stdout = os.Stdout
	shellCmd.Stderr = os.Stderr
	// Clone the namespaces inside the Linux kernel
	shellCmd.SysProcAttr = &syscall.SysProcAttr{
		Cloneflags: syscall.CLONE_NEWNS | syscall.CLONE_NEWUTS | syscall.CLONE_NEWIPC | syscall.CLONE_NEWPID | syscall.CLONE_NEWNET | syscall.CLONE_NEWUSER | syscall.CLONE_NEWCGROUP | syscall.CLONE_NEWTIME,
		UidMappings: []syscall.SysProcIDMap{
			{
				ContainerID: 0,
				HostID:      1002,
				Size:        1,
			},
		},
		GidMappings: []syscall.SysProcIDMap{
			{
				ContainerID: 0,
				HostID:      1002,
				Size:        1,
			},
		},
	}
	// Variable for nsbox Processor IDentification (PID) that also converts it in to a string
	nsboxPid := strconv.Itoa(os.Getpid())
	fmt.Println("  "+bgGreen+textBoldWhite, " nsbox running as user:", os.Getuid(), "as PID:", nsboxPid, resetColour)
	// Run pivot root function
	opt1PivotRoot()
	fmt.Println("")
	shellCmd.Run()
}

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

// Futute use
func opt2() {
}

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

	option := []string{
		bgCyan + " " + opt1Name + "         ",
		bgBlue + " " + opt2Name + "            ",
		bgPurple + " " + opt3Name + "            ",
		bgYellow + " " + opt4Name + "            ",
		bgBlack + " " + opt5Name + "            ",
		bgRed + " " + opt6Name + "            "}
	for index, value := range option {
		fmt.Print(bgWhite+textBoldWhite+"  ", value, "[", index+1, "] ", resetColour)
		background(25)
		background(bgWidth)
	}

	fmt.Println("")
	fmt.Print(textBoldBlack + "   Please enter an option: ")
	var input string
	fmt.Scan(&input)
	fmt.Println("" + resetColour)

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
		background(bgWidth)
		fmt.Print(bgWhite+"        "+resetColour+bgRed+textBoldWhite+" The input must be a number between 1-", len(option), " "+resetColour)
		background(6)
		background(bgWidth)
		fmt.Println("")
		continueButton()
	}
}

func main() {
	if runtime.GOOS != "linux" {
		fmt.Println("Operating system must be GNU/Linux to work")
	} else {
		mainMenu()
	}
}
