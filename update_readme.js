const thisYear = new Date().getFullYear()
const startTimeOfThisYear = new Date(`${thisYear}-01-01T00:00:00+00:00`).getTime()
const endTimeOfThisYear = new Date(`${thisYear}-12-31T23:59:59+00:00`).getTime()
const progressOfThisYear = (Date.now() - startTimeOfThisYear) / (endTimeOfThisYear - startTimeOfThisYear)
const progressBarOfThisYear = generateProgressBar()

function generateProgressBar() {
    const progressBarCapacity = 30
    const passedProgressBarIndex = parseInt(progressOfThisYear * progressBarCapacity)
    const passedProgressBar = Array.from({length: passedProgressBarIndex}, _ => '█')
    const leftProgressBar = Array.from({length: progressBarCapacity - passedProgressBarIndex}, _ => '▁')
    return `{ ${passedProgressBar.concat(leftProgressBar).join('')} }`
}

const readme = `\
### Hi there 👋

⏳ Year progress ${progressBarOfThisYear} ${(progressOfThisYear * 100).toFixed(2)} %

⏰ Updated on ${new Date().toUTCString()} with JavaScript.

![build](https://github.com/shenxianpeng/shenxianpeng/workflows/build/badge.svg) ![Profile views](https://gpvc.arturio.dev/shenxianpeng)\
`

console.log(readme)
