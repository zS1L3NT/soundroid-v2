export const data = <T = any>(data: T, status = 200) => ({
	data,
	status
})

export const error = (message: string, status = 400) => ({
	data: {
		message
	},
	status
})

export const redirect = (url: string) => ({
	redirect: url
})
