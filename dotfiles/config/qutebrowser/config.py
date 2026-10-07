# Qutebrowser configuration
#
# Autoconfig.yml has been merged into this file.
# Changes made through qutebrowser's :set/:bind commands will no longer
# be loaded automatically from autoconfig.yml.

# ---------------------------------------------------------------------------
# Aliases
# ---------------------------------------------------------------------------

c.aliases = {
    'q': 'close',
    'qa': 'quit',
    'tc': 'tab-close',
    'w': 'session-save',
    'wq': 'quit --save',
    'wqa': 'quit --save',
}


# ---------------------------------------------------------------------------
# Qt
# ---------------------------------------------------------------------------

c.qt.highdpi = False
c.qt.workarounds.disable_hangouts_extension = False


# ---------------------------------------------------------------------------
# Content
# ---------------------------------------------------------------------------

c.content.cookies.accept = 'no-3rdparty'

c.content.default_encoding = 'utf-8'

c.content.headers.accept_language = 'de-DE,de;q=0.9,en;q=0.6'

c.content.blocking.method = 'both'

c.content.blocking.hosts.lists = [
    'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts',
]

c.content.blocking.adblock.lists = [
    'https://easylist.to/easylist/easylist.txt',
    'https://easylist.to/easylist/easyprivacy.txt',
    'https://easylist.to/easylistgermany/easylistgermany.txt',
]

c.content.local_content_can_access_remote_urls = True

c.content.notifications.presenter = 'libnotify'

c.content.unknown_url_scheme_policy = 'allow-all'


# ---------------------------------------------------------------------------
# Downloads
# ---------------------------------------------------------------------------

c.downloads.location.directory = '~/Downloads'
c.downloads.open_dispatcher = 'xdg-open'


# ---------------------------------------------------------------------------
# Editor
# ---------------------------------------------------------------------------

c.editor.command = [
    'nvim',
    '-f',
    '{file}',
    '-c',
    'normal {line}G{column0}l',
]


# ---------------------------------------------------------------------------
# Fonts
# ---------------------------------------------------------------------------

c.fonts.default_family = 'JetBrainsMono Nerd Font Mono'
c.fonts.default_size = '14pt'

c.fonts.web.family.fixed = None
c.fonts.web.family.standard = None

c.fonts.web.size.default = 16
c.fonts.web.size.default_fixed = 14


# ---------------------------------------------------------------------------
# Scrolling
# ---------------------------------------------------------------------------

c.scrolling.smooth = True


# ---------------------------------------------------------------------------
# URL / Search
# ---------------------------------------------------------------------------

c.url.default_page = 'https://startpage.com/'

c.url.start_pages = 'https://startpage.com'

c.url.searchengines = {
    'DEFAULT': 'https://www.startpage.com/do/search?query={}',
    'asn': 'https://api.hackertarget.com/aslookup/?q={}',
    'br': 'https://search.brave.com/search?q={}',
    'de': 'https://de.thefreedictionary.com/{}',
    'ody': 'https://odysee.com/$/search?q={}',
    'q': 'https://lite.qwant.com/?q={}',
    'tr': 'https://www.linguee.com/english-german/search?source=auto&query={}',
    'ts': 'https://www.openthesaurus.de/synonyme/{}',
    'wp': 'https://de.wikipedia.org/w/index.php?search={}',
    'yt': 'https://inv.thepixora.com/search?q={}',
}


# ---------------------------------------------------------------------------
# Zoom
# ---------------------------------------------------------------------------

c.zoom.default = '125%'


# ---------------------------------------------------------------------------
# Colors

# Tokyo Night palette
# bg     #1a1b26
# fg     #a9b1d6
# blk    #24283b
# red    #f7768e
# grn    #9ece6a
# ylw    #e0af68
# blu    #7aa2f7
# mag    #bb9af7
# cyn    #7dcfff
# brblk  #414868
# white  #c0caf5

c.colors.completion.fg = '#a9b1d6'
c.colors.completion.category.fg = '#7dcfff'
c.colors.completion.category.bg = '#24283b'
c.colors.completion.even.bg = '#1a1b26'
c.colors.completion.odd.bg = '#24283b'
c.colors.completion.item.selected.bg = '#7aa2f7'
c.colors.completion.item.selected.fg = '#1a1b26'
c.colors.completion.match.fg = '#e0af68'

c.colors.downloads.bar.bg = '#1a1b26'
c.colors.downloads.start.bg = '#7aa2f7'
c.colors.downloads.start.fg = '#1a1b26'
c.colors.downloads.stop.bg = '#9ece6a'
c.colors.downloads.stop.fg = '#1a1b26'
c.colors.downloads.error.bg = '#f7768e'
c.colors.downloads.error.fg = '#1a1b26'

c.colors.hints.bg = '#e0af68'
c.colors.hints.fg = '#1a1b26'
c.colors.hints.match.fg = '#bb9af7'

c.colors.keyhint.fg = '#a9b1d6'
c.colors.keyhint.suffix.fg = '#7dcfff'
c.colors.keyhint.bg = '#24283b'

c.colors.messages.info.bg = '#24283b'
c.colors.messages.info.fg = '#7dcfff'
c.colors.messages.warning.bg = '#e0af68'
c.colors.messages.warning.fg = '#1a1b26'
c.colors.messages.error.bg = '#f7768e'
c.colors.messages.error.fg = '#1a1b26'

c.colors.prompts.bg = '#24283b'
c.colors.prompts.fg = '#a9b1d6'
c.colors.prompts.selected.bg = '#7aa2f7'
c.colors.prompts.selected.fg = '#1a1b26'

c.colors.statusbar.normal.bg = '#1a1b26'
c.colors.statusbar.normal.fg = '#a9b1d6'
c.colors.statusbar.insert.bg = '#9ece6a'
c.colors.statusbar.insert.fg = '#1a1b26'
c.colors.statusbar.passthrough.bg = '#bb9af7'
c.colors.statusbar.passthrough.fg = '#1a1b26'
c.colors.statusbar.private.bg = '#24283b'
c.colors.statusbar.private.fg = '#bb9af7'
c.colors.statusbar.command.bg = '#24283b'
c.colors.statusbar.command.fg = '#a9b1d6'
c.colors.statusbar.command.private.bg = '#24283b'
c.colors.statusbar.command.private.fg = '#bb9af7'
c.colors.statusbar.progress.bg = '#7dcfff'

c.colors.tabs.bar.bg = '#1a1b26'
c.colors.tabs.even.bg = '#24283b'
c.colors.tabs.even.fg = '#a9b1d6'
c.colors.tabs.odd.bg = '#1a1b26'
c.colors.tabs.odd.fg = '#a9b1d6'
c.colors.tabs.selected.even.bg = '#7aa2f7'
c.colors.tabs.selected.even.fg = '#1a1b26'
c.colors.tabs.selected.odd.bg = '#7aa2f7'
c.colors.tabs.selected.odd.fg = '#1a1b26'
c.colors.tabs.pinned.selected.even.bg = '#7aa2f7'
c.colors.tabs.pinned.selected.even.fg = '#1a1b26'
c.colors.tabs.pinned.selected.odd.bg = '#7aa2f7'
c.colors.tabs.pinned.selected.odd.fg = '#1a1b26'
c.colors.tabs.pinned.even.bg = '#24283b'
c.colors.tabs.pinned.even.fg = '#a9b1d6'
c.colors.tabs.pinned.odd.bg = '#1a1b26'
c.colors.tabs.pinned.odd.fg = '#a9b1d6'
c.colors.tabs.indicator.start = '#7dcfff'
c.colors.tabs.indicator.stop = '#7dcfff'
c.colors.tabs.indicator.error = '#f7768e'
c.colors.tabs.indicator.system = 'none'

c.colors.webpage.bg = '#1a1b26'
c.colors.webpage.preferred_color_scheme = 'dark'

c.colors.webpage.darkmode.enabled = False
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.policy.page = 'smart'


# ---------------------------------------------------------------------------
# Key mappings
# ---------------------------------------------------------------------------

c.bindings.key_mappings = {
    '<Ctrl+6>': '<Ctrl+^>',
    '<Ctrl+Enter>': '<Ctrl+Return>',
    '<Ctrl+[>': '<Escape>',
    '<Ctrl+j>': '<Return>',
    '<Ctrl+m>': '<Return>',
    '<Enter>': '<Return>',
    '<Shift+Enter>': '<Return>',
    '<Shift+Return>': '<Return>',
}


# ---------------------------------------------------------------------------
# Normal mode bindings
# ---------------------------------------------------------------------------

config.bind(',v', 'hint links spawn mpv {hint-url}')
config.bind(',i', 'hint images download')

config.bind('<Backspace>', ':back')
config.bind('<Shift+Left>', 'tab-prev')
config.bind('<Shift+Right>', 'tab-next')

config.bind('C', 'tab-close')
config.bind('J', 'tab-prev')
config.bind('K', 'tab-next')

config.bind('xb', 'config-cycle statusbar.show always never')
config.bind('xt', 'config-cycle tabs.show always never')
config.bind(
    'xx',
    'config-cycle statusbar.show always never;; '
    'config-cycle tabs.show always never',
)

# Keep q disabled in normal mode and map tab-next to K.
config.unbind('q')
config.bind('tab-next', 'K')


c.auto_save.session = True


# ---------------------------------------------------------------------------
# UI
# ---------------------------------------------------------------------------

c.statusbar.show = 'always'
c.tabs.show = 'always'


# ---------------------------------------------------------------------------
# Other Config
# ---------------------------------------------------------------------------

# Disable autoconfig.yml
config.load_autoconfig(False)

