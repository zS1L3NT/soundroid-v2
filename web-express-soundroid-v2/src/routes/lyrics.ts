import axios, { AxiosResponse } from "axios"
import googleIt from "google-it"
import { useTry } from "no-try"
import similarity from "string-similarity"
import { OBJECT, STRING } from "validate-any"

import { Route } from "../setup"

export class GET extends Route<any, { query: string }> {
	override queryValidator = OBJECT({
		query: STRING()
	})

	async handle() {
		const [googleLyrics, textylLyrics] = await Promise.all([
			this.getLyricsFromGoogle(),
			this.getLyricsFromTextyl()
		])

		if (textylLyrics === null) {
			if (googleLyrics === null) {
				return this.throw("Failed to find lyrics for the search query")
			} else {
				return this.respond(googleLyrics)
			}
		} else if (googleLyrics === null) {
			return this.respond(textylLyrics)
		}

		if (
			similarity.compareTwoStrings(
				googleLyrics.lines
					.join(" ")
					.replace(/[\n ]*/g, " ")
					.toLowerCase(),
				textylLyrics.lines
					.join(" ")
					.replace(/[\n ]*/g, " ")
					.toLowerCase()
			) >= 0.8
		) {
			return this.respond(textylLyrics)
		} else {
			return this.respond(googleLyrics)
		}
	}

	async getLyricsFromGoogle() {
		const results = await googleIt({
			query: `${this.query.query} site:genius.com`,
			"no-display": true
		})

		const result = results
			.filter(result => result.link.match(/^https:\/\/genius\.com\/[\w-]+$/))
			.filter(result => !result.title.match(/\(Romanized|\w+ Translation\) Lyrics - /))
			.at(0)

		if (!result) {
			return null
		}

		const html = (await axios.get<string>(result.link)).data
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
			return null
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

		return {
			lines: getLyrics(lyrics)
				.replaceAll(/(\[.*\])/g, "")
				.replaceAll(/\n{3,}/g, "\n\n")
				.trim()
				.split("\n"),
			times: null
		}
	}

	async getLyricsFromTextyl() {
		try {
			const result = <AxiosResponse<{ seconds: number; lyrics: string }[]>>(
				await axios.get(`https://api.textyl.co/api/lyrics?q=${this.query.query}`)
			)
			return {
				lines: result.data.map(({ lyrics }) => lyrics),
				times: result.data.map(({ seconds }) => seconds)
			}
		} catch (e) {
			return null
		}
	}
}
