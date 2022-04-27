const queue: number[] = []

export const generateRID = () => {
	if (queue.length === 0) {
		queue.push(1)
	} else {
		queue.push(queue.at(-1)! + 1)
	}
	return `{#${queue.at(-1)!}}`
}

export const clearRID = (rid: string) => {
	setTimeout(() => {
		queue.splice(queue.indexOf(+rid.slice(2, -1)), 1)
	}, 60_000)
}
