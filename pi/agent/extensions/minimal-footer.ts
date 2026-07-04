/**
 * Minimal Footer — compact status line for Pi.
 *
 * Left: ~/path/to/project • git:branch± • provider/model (thinking) • extension statuses
 * Right: [####......] 40% (128K)
 *
 * This is adapted from https://gist.github.com/deepakness/81e716c4654d22bee6b3a830553ec004
 * for the extension set installed here. In particular, @narumitw/pi-goal writes its
 * status under the `goal` status key with values like `active 3m`; it does not put
 * the word “goal” in the value, so this footer reads status map keys as well as values.
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

type ThinkingLevel = "off" | "minimal" | "low" | "medium" | "high" | "xhigh";
type RgbColor = { r: number; g: number; b: number };
type ModelWithThinking = {
	id?: string;
	provider?: string;
	reasoning?: boolean;
	contextWindow?: number;
	thinkingLevelMap?: Partial<Record<ThinkingLevel, string | null>>;
};

type ExtensionStatus = { key: string; value: string };

const THINKING_LEVELS: ThinkingLevel[] = ["off", "minimal", "low", "medium", "high", "xhigh"];

const EFFORT_COLOR_STOPS: RgbColor[] = [
	{ r: 142, g: 142, b: 147 },
	{ r: 52, g: 199, b: 89 },
	{ r: 255, g: 214, b: 10 },
	{ r: 255, g: 159, b: 10 },
	{ r: 255, g: 69, b: 58 },
];

const CONTEXT_COLOR_STOPS: RgbColor[] = [
	{ r: 52, g: 199, b: 89 },
	{ r: 255, g: 214, b: 10 },
	{ r: 255, g: 159, b: 10 },
	{ r: 255, g: 69, b: 58 },
];

const PROVIDER_COLORS: Record<string, RgbColor> = {
	anthropic: { r: 191, g: 90, b: 242 },
	openai: { r: 52, g: 199, b: 89 },
	"openai-codex": { r: 52, g: 199, b: 89 },
	google: { r: 66, g: 133, b: 244 },
	gemini: { r: 66, g: 133, b: 244 },
	github: { r: 175, g: 82, b: 222 },
	copilot: { r: 175, g: 82, b: 222 },
	openrouter: { r: 255, g: 159, b: 10 },
	ollama: { r: 142, g: 142, b: 147 },
	local: { r: 142, g: 142, b: 147 },
};

const ANSI_RE = /\x1b\[[0-9;]*m/g;

function visibleWidth(text: string): number {
	return Array.from(text.replace(ANSI_RE, "")).length;
}

function truncateToWidth(text: string, maxWidth: number): string {
	if (maxWidth <= 0) return "";
	if (visibleWidth(text) <= maxWidth) return text;
	const targetWidth = Math.max(0, maxWidth - 1);
	let width = 0;
	let out = "";
	for (let i = 0; i < text.length; ) {
		if (text[i] === "\x1b") {
			const match = text.slice(i).match(/^\x1b\[[0-9;]*m/);
			if (match) {
				out += match[0];
				i += match[0].length;
				continue;
			}
		}
		const char = Array.from(text.slice(i))[0];
		if (!char) break;
		if (width + 1 > targetWidth) break;
		out += char;
		width += 1;
		i += char.length;
	}
	return `${out}…\x1b[39m`;
}

export default function minimalFooter(pi: ExtensionAPI) {
	let tuiRef: { requestRender(): void } | null = null;
	let cwd = process.cwd();
	let thinkingLevel: ThinkingLevel = "off";
	let currentModel: ModelWithThinking | undefined;
	let isDirty = false;

	pi.on("model_select", async (event) => {
		currentModel = event.model as ModelWithThinking;
		tuiRef?.requestRender();
	});

	pi.on("thinking_level_select", async (event) => {
		thinkingLevel = event.level as ThinkingLevel;
		tuiRef?.requestRender();
	});

	pi.on("turn_end", () => {
		void refreshDirty();
	});

	async function refreshDirty() {
		const insideWorkTree = await pi
			.exec("git", ["rev-parse", "--is-inside-work-tree"], { cwd })
			.catch(() => undefined);

		if (insideWorkTree?.stdout.trim() !== "true") {
			setDirty(false);
			return;
		}

		const status = await pi.exec("git", ["status", "--porcelain"], { cwd }).catch(() => undefined);
		setDirty((status?.stdout.trim().length ?? 0) > 0);
	}

	function setDirty(next: boolean) {
		if (next === isDirty) return;
		isDirty = next;
		tuiRef?.requestRender();
	}

	function formatContextWindow(n: number | undefined): string {
		if (!n) return "";
		if (n >= 1_000_000) return `${(n / 1_000_000).toFixed(n % 1_000_000 === 0 ? 0 : 1)}M`;
		if (n >= 1_000) return `${(n / 1_000).toFixed(n % 1_000 === 0 ? 0 : 1)}K`;
		return `${n}`;
	}

	function middleTruncatePath(path: string, maxWidth = 42): string {
		if (visibleWidth(path) <= maxWidth) return path;
		const parts = path.split("/").filter(Boolean);
		const isHomePath = path.startsWith("~/");
		const isAbsolutePath = path.startsWith("/");
		const first = parts[0] === "~" ? parts[1] : parts[0];
		const last = parts[parts.length - 1];
		if (!first || !last) return truncateToWidth(path, maxWidth);
		const prefix = isHomePath ? `~/${first}` : isAbsolutePath ? `/${first}` : first;
		const shortened = `${prefix}/.../${last}`;
		return visibleWidth(shortened) <= maxWidth ? shortened : truncateToWidth(shortened, maxWidth);
	}

	function formatDirectory(path: string): string {
		const home = process.env.HOME || process.env.USERPROFILE;
		const displayPath = home && path.startsWith(home) ? `~${path.slice(home.length)}` : path;
		return middleTruncatePath(displayPath);
	}

	function getExtensionStatuses(statuses: unknown): ExtensionStatus[] {
		if (statuses instanceof Map) {
			return Array.from(statuses.entries())
				.filter((entry): entry is [string, string] => typeof entry[0] === "string" && typeof entry[1] === "string")
				.map(([key, value]) => ({ key, value }));
		}
		if (Array.isArray(statuses)) {
			return statuses
				.filter((status): status is string => typeof status === "string")
				.map((value) => ({ key: "", value }));
		}
		return [];
	}

	function formatExtensionStatus({ key, value }: ExtensionStatus): string {
		// @narumitw/pi-goal uses key `goal` and plain values like `active 3m`.
		if (key === "goal") return `🎯 ${value}`;
		return key ? `${key}:${value}` : value;
	}

	function isThinkingLevel(value: string): value is ThinkingLevel {
		return THINKING_LEVELS.includes(value as ThinkingLevel);
	}

	function getSupportedThinkingLevels(model: ModelWithThinking | undefined): ThinkingLevel[] {
		if (!model || model.reasoning === false) return ["off"];
		const map = model.thinkingLevelMap ?? {};
		const supported = THINKING_LEVELS.filter((level) => map[level] !== null);
		return supported.length > 0 ? supported : ["off"];
	}

	function interpolateColor(position: number, stops: RgbColor[] = EFFORT_COLOR_STOPS): RgbColor {
		const safeStops = stops.length > 0 ? stops : EFFORT_COLOR_STOPS;
		const clamped = Math.max(0, Math.min(1, position));
		const scaled = clamped * (safeStops.length - 1);
		const leftIndex = Math.floor(scaled);
		const rightIndex = Math.min(safeStops.length - 1, leftIndex + 1);
		const mix = scaled - leftIndex;
		const left = safeStops[leftIndex];
		const right = safeStops[rightIndex];
		return {
			r: Math.round(left.r + (right.r - left.r) * mix),
			g: Math.round(left.g + (right.g - left.g) * mix),
			b: Math.round(left.b + (right.b - left.b) * mix),
		};
	}

	function colorRgb(text: string, { r, g, b }: RgbColor): string {
		return `\x1b[38;2;${r};${g};${b}m${text}\x1b[39m`;
	}

	function colorThinkingLabel(level: string, label: string, model: ModelWithThinking | undefined): string {
		if (!isThinkingLevel(level)) return label;
		const supported = getSupportedThinkingLevels(model);
		const supportedIndex = supported.indexOf(level);
		const fallbackIndex = THINKING_LEVELS.indexOf(level);
		const position =
			supportedIndex >= 0
				? supported.length <= 1
					? 0
					: supportedIndex / (supported.length - 1)
				: fallbackIndex / (THINKING_LEVELS.length - 1);
		return colorRgb(label, interpolateColor(position));
	}

	function getProviderColor(provider: string | undefined): RgbColor | undefined {
		return provider ? PROVIDER_COLORS[provider.toLowerCase()] : undefined;
	}

	pi.on("session_start", async (_event, ctx) => {
		cwd = ctx.cwd;
		currentModel = ctx.model as ModelWithThinking | undefined;
		thinkingLevel = pi.getThinkingLevel();
		void refreshDirty();

		ctx.ui.setFooter((tui, theme, footerData) => {
			tuiRef = tui;
			const unsub = footerData.onBranchChange(() => tui.requestRender());

			return {
				dispose() {
					unsub();
					tuiRef = null;
				},
				invalidate() {
					void refreshDirty();
				},
				render(width: number): string[] {
					const displayCwd = formatDirectory(cwd);
					const lastSlash = displayCwd.lastIndexOf("/");
					const pathPrefix = lastSlash >= 0 ? displayCwd.slice(0, lastSlash + 1) : "";
					const projectName = lastSlash >= 0 ? displayCwd.slice(lastSlash + 1) : displayCwd;
					const pathStr = projectName
						? theme.fg("dim", pathPrefix) + theme.fg("accent", theme.bold(projectName))
						: theme.fg("dim", displayCwd);

					const branch = footerData.getGitBranch();
					const branchStr = branch ? theme.fg(isDirty ? "warning" : "success", `git:${branch}${isDirty ? "±" : ""}`) : "";

					const activeModel = currentModel || (ctx.model as ModelWithThinking | undefined);
					const model = activeModel?.id || ctx.model?.id || "no-model";
					const provider = activeModel?.provider;
					const providerColor = getProviderColor(provider);
					const modelStr =
						provider && !model.includes("/")
							? (providerColor ? colorRgb(provider, providerColor) : theme.fg("muted", provider)) +
								theme.fg("dim", "/") +
								theme.fg("accent", model)
							: theme.fg("accent", model);

					const supportedThinkingLevels = getSupportedThinkingLevels(activeModel);
					const showThinkingLabel = thinkingLevel !== "off" || supportedThinkingLevels.length > 1;
					const thinkLabel = showThinkingLabel ? colorThinkingLabel(thinkingLevel, ` (${thinkingLevel})`, activeModel) : "";

					const extensionStatuses = getExtensionStatuses(footerData.getExtensionStatuses?.())
						.map(formatExtensionStatus)
						.map((status) => theme.fg(status.startsWith("🎯") ? "warning" : "dim", status));

					const left = [pathStr, branchStr, modelStr + thinkLabel, ...extensionStatuses]
						.filter(Boolean)
						.join(theme.fg("dim", " • "));

					const usage = ctx.getContextUsage();
					const pct = usage?.percent ?? 0;
					const pctStr = usage?.percent !== null && usage?.percent !== undefined ? `${Math.round(pct)}%` : "?";
					const contextWindow = usage?.contextWindow ?? activeModel?.contextWindow;
					const ctxRgb = interpolateColor(pct / 100, CONTEXT_COLOR_STOPS);
					const blocks = 10;
					const filled = Math.max(0, Math.min(blocks, Math.round((pct / 100) * blocks)));
					const bar = colorRgb("#".repeat(filled), ctxRgb) + theme.fg("dim", ".".repeat(blocks - filled));
					const ctxWinStr = contextWindow ? ` (${formatContextWindow(contextWindow)})` : "";
					const right =
						colorRgb("[", ctxRgb) +
						bar +
						colorRgb("] ", ctxRgb) +
						colorRgb(pctStr, ctxRgb) +
						(pct >= 75 ? colorRgb(ctxWinStr, ctxRgb) : theme.fg("dim", ctxWinStr));

					const leftW = visibleWidth(left);
					const rightW = visibleWidth(right);
					if (leftW + rightW <= width) {
						return [left + " ".repeat(width - leftW - rightW) + right];
					}
					return [truncateToWidth(left, width), truncateToWidth(right, width)];
				},
			};
		});
	});
}
