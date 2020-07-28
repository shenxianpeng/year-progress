package main

import (
	"log"
	"math"
	"os"
	"strconv"
	"time"
)

func main(){
	t := time.Now()
	currentDate := t.Format("2006-01-02 15:04:05")
	thisYear := time.Now().Year()
	startTimeOfThisYear := time.Date(thisYear, time.January, 0, 0, 0, 0, 0, time.UTC).UnixNano()
	endTimeOfThisYear := time.Date(thisYear, time.December, 31, 23, 59, 59, 0, time.UTC).UnixNano()

	progressOfThisYear := float64(time.Now().UnixNano()-startTimeOfThisYear) /
		float64(endTimeOfThisYear-startTimeOfThisYear)

	progressBarCapacity := 30.0
	passedProgressBarIndex := int(math.Floor(progressOfThisYear * progressBarCapacity))

	passedProgressBar := ""
	for i := 0; i < passedProgressBarIndex; i++ {
		passedProgressBar = passedProgressBar + "█"
	}

	leftProgressBar := ""
	for i := 0; i < int(progressBarCapacity) - int(passedProgressBarIndex); i++ {
		leftProgressBar = leftProgressBar + "▁"
	}

	file, err := os.Create("README.md")
	if err != nil {
		log.Fatalf("Failed opening file: %s", err)
	}
	defer file.Close()

	README :=
			"### Hi there 👋 \n\n" +
			"⏳ Year progress { " + passedProgressBar + leftProgressBar + " } " +strconv.FormatFloat(progressOfThisYear * 100, 'f', 2, 64) + " %\n\n" +
			"⏰ Updated on " + currentDate + " with Golang.\n\n" +
			"![build](https://github.com/shenxianpeng/shenxianpeng/workflows/build/badge.svg)"

	_, err = file.WriteString(README)
	if err != nil {
		log.Fatalf("Failed write to file: %s", err)
	}
}