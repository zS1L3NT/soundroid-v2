declare module "google-it" {
	export default function googleIt(config: object): Promise<
		{
			title: string
			link: string
			snippet: string
		}[]
	>
}
