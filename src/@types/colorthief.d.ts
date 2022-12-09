declare module "colorthief" {
	export function getColor(url: string): Promise<[number, number, number]>
}
