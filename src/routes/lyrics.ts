import axios from "axios"
import { useTry } from "no-try"

import { genius } from "../apis"
import { Route } from "../setup"

export class GET extends Route {
	async handle() {
		if (this.query.query) {
			const results = await genius.search(this.query.query)
			this.respond(
				results
					.map((r: any) => r.result)
					.map((result: any) => ({
						id: result.id,
						title: result.title,
						artiste: result.artist_names
					}))
			)
			return
		}

		if (this.query.id) {
			// LOL I just lifted this directly from https://github.com/zS1L3NT/ts-discord-soundroid/blob/main/src/utils/ApiHelper.ts
			const html = (await axios.get<string>(`https://genius.com/songs/${this.query.id}`)).data

			const lyrics = html
				.match(/JSON\.parse\('(.*)'\)/)!
				.map(j => j.slice(12, -2))
				.map(j => j.replaceAll("\\\\", "\\"))
				.map(j => j.replaceAll('\\"', '"'))
				.map(j => j.replaceAll("\\'", "'"))
				.map(j => useTry(() => JSON.parse(j))[1])
				.filter(j => !!j)
				.at(0)?.songPage?.lyricsData?.body

			if (lyrics === undefined) {
				this.throw("Failed to fetch lyrics from Genius API")
				return
			}

			const getLyrics = (lyrics: any): string => {
				if (typeof lyrics === "string") {
					return lyrics
				}

				if ("children" in lyrics) {
					return lyrics.children.map(getLyrics).join("")
				}

				if ("tag" in lyrics && lyrics.tag === "br") {
					return "\n"
				}

				return ""
			}

			this.respond(
				getLyrics(lyrics)
					.replaceAll("\n\n", "\n")
					.replaceAll(/(\[.*\])/g, "\n`$1`")
			)
			return
		}

		this.throw("No query or id specified")
	}
}
