/* See LICENSE file for copyright and license details. */

/* Helper macros for spawning commands */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#define CMD(...)   { .v = (const char*[]){ __VA_ARGS__, NULL } }

/* appearance */
static const unsigned int borderpx       = 2;   /* border pixel of windows */
static const unsigned int snap           = 32;  /* snap pixel */
static const int scalepreview            = 4;        /* Tag preview scaling */
static const char autostartblocksh[]     = "autostart_blocking.sh";
static const char autostartsh[]          = "autostart.sh";
static const char dwmdir[]               = "dwm";
static const char localshare[]           = ".local/share";
static const int showbar                 = 1;   /* 0 means no bar */
static const int topbar                  = 1;   /* 0 means bottom bar */
/* Status is to be shown on: -1 (all monitors), 0 (a specific monitor by index), 'A' (active monitor) */
static const int statusmon               = 'A';
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int showsystray             = 1;   /* 0 means no systray */

/* Indicators: see patch/bar_indicators.h for options */
static int tagindicatortype              = INDICATOR_TOP_LEFT_SQUARE;
static int tiledindicatortype            = INDICATOR_NONE;
static int floatindicatortype            = INDICATOR_TOP_LEFT_SQUARE;
static const char *fonts[]               = { "monospace:size=10" };
static const char dmenufont[]            = "monospace:size=10";

static char c000000[]                    = "#000000"; // placeholder value

static char normfgcolor[]                = "#ebdbb2";
static char normbgcolor[]                = "#282828";
static char normbordercolor[]            = "#3c3836";
static char normfloatcolor[]             = "#db8fd9";

static char selfgcolor[]                 = "#fbf1c7";
static char selbgcolor[]                 = "#d65d0e";
static char selbordercolor[]             = "#d65d0e";
static char selfloatcolor[]              = "#d65d0e";

static char titlenormfgcolor[]           = "#ebdbb2";
static char titlenormbgcolor[]           = "#282828";
static char titlenormbordercolor[]       = "#3c3836";
static char titlenormfloatcolor[]        = "#3c3836";

static char titleselfgcolor[]            = "#fbf1c7";
static char titleselbgcolor[]            = "#d65d0e";
static char titleselbordercolor[]        = "#d65d0e";
static char titleselfloatcolor[]         = "#d65d0e";

static char tagsnormfgcolor[]            = "#ebdbb2";
static char tagsnormbgcolor[]            = "#282828";
static char tagsnormbordercolor[]        = "#3c3836";
static char tagsnormfloatcolor[]         = "#3c3836";

static char tagsselfgcolor[]             = "#fbf1c7";
static char tagsselbgcolor[]             = "#d65d0e";
static char tagsselbordercolor[]         = "#d65d0e";
static char tagsselfloatcolor[]          = "#d65d0e";

static char hidnormfgcolor[]             = "#005577";
static char hidselfgcolor[]              = "#227799";
static char hidnormbgcolor[]             = "#222222";
static char hidselbgcolor[]              = "#222222";

static char urgfgcolor[]                 = "#bbbbbb";
static char urgbgcolor[]                 = "#222222";
static char urgbordercolor[]             = "#ff0000";
static char urgfloatcolor[]              = "#db8fd9";


static char *colors[][ColCount] = {
	/*                       fg                bg                border                float */
	[SchemeNorm]         = { normfgcolor,      normbgcolor,      normbordercolor,      normfloatcolor },
	[SchemeSel]          = { selfgcolor,       selbgcolor,       selbordercolor,       selfloatcolor },
	[SchemeTitleNorm]    = { titlenormfgcolor, titlenormbgcolor, titlenormbordercolor, titlenormfloatcolor },
	[SchemeTitleSel]     = { titleselfgcolor,  titleselbgcolor,  titleselbordercolor,  titleselfloatcolor },
	[SchemeTagsNorm]     = { tagsnormfgcolor,  tagsnormbgcolor,  tagsnormbordercolor,  tagsnormfloatcolor },
	[SchemeTagsSel]      = { tagsselfgcolor,   tagsselbgcolor,   tagsselbordercolor,   tagsselfloatcolor },
	[SchemeHidNorm]      = { hidnormfgcolor,   hidnormbgcolor,   c000000,              c000000 },
	[SchemeHidSel]       = { hidselfgcolor,    hidselbgcolor,    c000000,              c000000 },
	[SchemeUrg]          = { urgfgcolor,       urgbgcolor,       urgbordercolor,       urgfloatcolor },
};

/* Tags
 * In a traditional dwm the number of tags in use can be changed simply by changing the number
 * of strings in the tags array. This build does things a bit different which has some added
 * benefits. If you need to change the number of tags here then change the NUMTAGS macro in dwm.c.
 *
 * Examples:
 *
 *  1) static char *tagicons[][NUMTAGS*2] = {
 *         [DEFAULT_TAGS] = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I" },
 *     }
 *
 *  2) static char *tagicons[][1] = {
 *         [DEFAULT_TAGS] = { "•" },
 *     }
 *
 * The first example would result in the tags on the first monitor to be 1 through 9, while the
 * tags for the second monitor would be named A through I. A third monitor would start again at
 * 1 through 9 while the tags on a fourth monitor would also be named A through I. Note the tags
 * count of NUMTAGS*2 in the array initialiser which defines how many tag text / icon exists in
 * the array. This can be changed to *3 to add separate icons for a third monitor.
 *
 * For the second example each tag would be represented as a bullet point. Both cases work the
 * same from a technical standpoint - the icon index is derived from the tag index and the monitor
 * index. If the icon index is is greater than the number of tag icons then it will wrap around
 * until it an icon matches. Similarly if there are two tag icons then it would alternate between
 * them. This works seamlessly with alternative tags and alttagsdecoration patches.
 */
static char *tagicons[][NUMTAGS] =
{
	[DEFAULT_TAGS]        = { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
	[ALTERNATIVE_TAGS]    = { "A", "B", "C", "D", "E", "F", "G", "H", "I" },
	[ALT_TAGS_DECORATION] = { "<1>", "<2>", "<3>", "<4>", "<5>", "<6>", "<7>", "<8>", "<9>" },
};

/* There are two options when it comes to per-client rules:
 *  - a typical struct table or
 *  - using the RULE macro
 *
 * A traditional struct table looks like this:
 *    // class      instance  title  wintype  tags mask  isfloating  monitor
 *    { "Gimp",     NULL,     NULL,  NULL,    1 << 4,    0,          -1 },
 *    { "Firefox",  NULL,     NULL,  NULL,    1 << 7,    0,          -1 },
 *
 * The RULE macro has the default values set for each field allowing you to only
 * specify the values that are relevant for your rule, e.g.
 *
 *    RULE(.class = "Gimp", .tags = 1 << 4)
 *    RULE(.class = "Firefox", .tags = 1 << 7)
 *
 * Refer to the Rule struct definition for the list of available fields depending on
 * the patches you enable.
 */
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 *	WM_WINDOW_ROLE(STRING) = role
	 *	_NET_WM_WINDOW_TYPE(ATOM) = wintype
	 */
	RULE(.wintype = WTYPE "DIALOG", .isfloating = 1)
	RULE(.wintype = WTYPE "UTILITY", .isfloating = 1)
	RULE(.wintype = WTYPE "TOOLBAR", .isfloating = 1)
	RULE(.wintype = WTYPE "SPLASH", .isfloating = 1)
	RULE(.class = "Gimp", .tags = 1 << 4)
	RULE(.class = "Firefox", .tags = 1 << 7)
};

/* Bar rules allow you to configure what is shown where on the bar, as well as
 * introducing your own bar modules.
 *
 *    monitor:
 *      -1  show on all monitors
 *       0  show on monitor 0
 *      'A' show on active monitor (i.e. focused / selected) (or just -1 for active?)
 *    bar - bar index, 0 is default, 1 is extrabar
 *    alignment - how the module is aligned compared to other modules
 *    widthfunc, drawfunc, clickfunc - providing bar module width, draw and click functions
 *    name - does nothing, intended for visual clue and for logging / debugging
 */
static const BarRule barrules[] = {
	/* monitor   bar    alignment         widthfunc                 drawfunc                clickfunc                hoverfunc                name */
	{ -1,        0,     BAR_ALIGN_LEFT,   width_tags,               draw_tags,              click_tags,              hover_tags,              "tags" },
	{  0,        0,     BAR_ALIGN_RIGHT,  width_systray,            draw_systray,           click_systray,           NULL,                    "systray" },
	{ -1,        0,     BAR_ALIGN_LEFT,   width_ltsymbol,           draw_ltsymbol,          click_ltsymbol,          NULL,                    "layout" },
	{ statusmon, 0,     BAR_ALIGN_RIGHT,  width_status,             draw_status,            click_status,            NULL,                    "status" },
	{ -1,        0,     BAR_ALIGN_NONE,   width_awesomebar,         draw_awesomebar,        click_awesomebar,        NULL,                    "awesomebar" },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = {
	"dmenu_run",
	"-m", dmenumon,
	"-fn", dmenufont,
	"-nb", normbgcolor,
	"-nf", normfgcolor,
	"-sb", selbgcolor,
	"-sf", selfgcolor,
	NULL
};
static const char *termcmd[]  = { "wezterm", NULL };
static const char *flameshot[] = { "flameshot", "gui", NULL };
static const char *roficmd[] = {
  "rofi",
  "-show",
  "drun",
  "-show-icons",
  "Papirus",
  "-font",
  "JetBrainsMonoNL Nerd Font Propo 15",
  NULL
};

static const Key keys[] = {
	/* modifier                     key            function                argument */
  // modifier
	{ MODKEY,                       XK_space,      spawn,                  {.v = roficmd }},
	{ MODKEY,                       XK_Return,     spawn,                  {.v = termcmd } },
  { 0,                            XK_F12,        spawn,                  {.v = flameshot}},
	{ MODKEY,                       XK_b,          togglebar,              {0} },
	{ MODKEY|ShiftMask,             XK_b,          toggletopbar,           {0} },
//	{ MODKEY,                       XK_j,          focusstack,             {.i = +1 } },
//	{ MODKEY,                       XK_k,          focusstack,             {.i = -1 } },
  /* Navegación entre ventanas */
	{ MODKEY,                       XK_Left,       focusdir,               {.i = 0 } }, // left
	{ MODKEY,                       XK_Right,      focusdir,               {.i = 1 } }, // right
	{ MODKEY,                       XK_Up,         focusdir,               {.i = 2 } }, // up
	{ MODKEY,                       XK_Down,       focusdir,               {.i = 3 } }, // down

  /* Colocar ventanas en el grid (rotarlas) */
	{ MODKEY|ControlMask,           XK_Left,       placedir,               {.i = 0 } }, // left
	{ MODKEY|ControlMask,           XK_Right,      placedir,               {.i = 1 } }, // right
	{ MODKEY|ControlMask,           XK_Up,         placedir,               {.i = 2 } }, // up
	{ MODKEY|ControlMask,           XK_Down,       placedir,               {.i = 3 } }, // down
//	{ MODKEY|Mod4Mask,              XK_Right,      rotatestack,            {.i = +1 } },
//	{ MODKEY|Mod4Mask,              XK_Left,       rotatestack,            {.i = -1 } },
//	{ MODKEY,                       XK_i,          incnmaster,             {.i = +1 } },
//	{ MODKEY,                       XK_d,          incnmaster,             {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_Left,       setmfact,                {.f = -0.05} },
	{ MODKEY|ShiftMask,             XK_Right,      setmfact,                {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Up,         setcfact,                {.f = +0.25} },
	{ MODKEY|ShiftMask,             XK_Down,       setcfact,                {.f = -0.25} },
//	{ MODKEY|ShiftMask,             XK_o,          setcfact,               {0} },
//	{ MODKEY|ShiftMask,             XK_j,          movestack,              {.i = +1 } },
//	{ MODKEY|ShiftMask,             XK_k,          movestack,              {.i = -1 } },
  
  /*cambiar el tamaño de las ventanas, para ventanas flotantes, si está en  modo tile, lo pone float*/
  { MODKEY|ShiftMask|ControlMask,             XK_Up,        exresize,               {.v = (int []){   0,  25 }}},  /* XK_KP_Up,    */
  { MODKEY|ShiftMask|ControlMask,             XK_Down,      exresize,               {.v = (int []){   0, -25 }}},  /* XK_KP_Down,  */
  { MODKEY|ShiftMask|ControlMask,             XK_Right,     exresize,               {.v = (int []){  25,   0 }}},  /* XK_KP_Right, */
  { MODKEY|ShiftMask|ControlMask,             XK_Left,      exresize,               {.v = (int []){ -25,   0 }}},  /* XK_KP_Left,  */
//  { MODKEY|ShiftMask,             XK_KP_5,       exresize,               {.v = (int []){  25,  25 }}},  /* XK_KP_Begin, */
//  { MODKEY|ShiftMask|ControlMask, XK_KP_5,       exresize,               {.v = (int []){ -25, -25 }}},  /* XK_KP_Begin, */



	{ MODKEY,                       XK_Return,     zoom,                   {0} },
	{ MODKEY,                       XK_Tab,        view,                   {0} },
	{ MODKEY|ControlMask,           XK_z,          showhideclient,         {0} },
	{ MODKEY,                       XK_w,          killclient,             {0} },
	{ MODKEY|ShiftMask,             XK_q,          quit,                   {0} },
//	{ MODKEY|ControlMask|ShiftMask, XK_q,          quit,                   {1} },
	{ MODKEY,                       XK_t,          setlayout,              {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,          setlayout,              {.v = &layouts[1]} },
//	{ MODKEY,                       XK_m,          setlayout,              {.v = &layouts[2]} },
//	{ MODKEY,                       XK_space,      setlayout,              {0} },
	{ MODKEY|ShiftMask,             XK_f,          togglefloating,         {0} },
	{ MODKEY,                       XK_y,          togglefullscreen,       {0} },
	{ MODKEY,                       XK_0,          view,                   {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,          tag,                    {.ui = ~0 } },
//	{ MODKEY,                       XK_comma,      focusmon,               {.i = -1 } },
//	{ MODKEY,                       XK_period,     focusmon,               {.i = +1 } },
//	{ MODKEY|ShiftMask,             XK_comma,      tagmon,                 {.i = -1 } },
//	{ MODKEY|ShiftMask,             XK_period,     tagmon,                 {.i = +1 } },
//	{ MODKEY,                       XK_KP_7,       explace,                {.ui = EX_NW }},   /* XK_KP_Home,  */
//	{ MODKEY,                       XK_KP_8,       explace,                {.ui = EX_N  }},   /* XK_KP_Up,    */
//	{ MODKEY,                       XK_KP_9,       explace,                {.ui = EX_NE }},   /* XK_KP_Prior, */
//	{ MODKEY,                       XK_KP_4,       explace,                {.ui = EX_W  }},   /* XK_KP_Left,  */
//	{ MODKEY,                       XK_KP_5,       explace,                {.ui = EX_C  }},   /* XK_KP_Begin, */
//	{ MODKEY,                       XK_KP_6,       explace,                {.ui = EX_E  }},   /* XK_KP_Right, */
//	{ MODKEY,                       XK_KP_1,       explace,                {.ui = EX_SW }},   /* XK_KP_End,   */
//	{ MODKEY,                       XK_KP_2,       explace,                {.ui = EX_S  }},   /* XK_KP_Down,  */
//	{ MODKEY,                       XK_KP_3,       explace,                {.ui = EX_SE }},   /* XK_KP_Next,  */
	TAGKEYS(                        XK_1,                                  0)
	TAGKEYS(                        XK_2,                                  1)
	TAGKEYS(                        XK_3,                                  2)
	TAGKEYS(                        XK_4,                                  3)
	TAGKEYS(                        XK_5,                                  4)
	TAGKEYS(                        XK_6,                                  5)
	TAGKEYS(                        XK_7,                                  6)
	TAGKEYS(                        XK_8,                                  7)
	TAGKEYS(                        XK_9,                                  8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask           button          function        argument */
	{ ClkLtSymbol,          0,                   Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,                   Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,                   Button1,        togglewin,      {0} },
	{ ClkWinTitle,          0,                   Button3,        showhideclient, {0} },
	{ ClkWinTitle,          0,                   Button2,        zoom,           {0} },
	{ ClkStatusText,        0,                   Button2,        spawn,          {.v = termcmd } },
	/* placemouse options, choose which feels more natural:
	 *    0 - tiled position is relative to mouse cursor
	 *    1 - tiled postiion is relative to window center
	 *    2 - mouse pointer warps to window center
	 *
	 * The moveorplace uses movemouse or placemouse depending on the floating state
	 * of the selected client. Set up individual keybindings for the two if you want
	 * to control these separately (i.e. to retain the feature to move a tiled window
	 * into a floating position).
	 */
	{ ClkClientWin,         MODKEY,              Button1,        moveorplace,    {.i = 1} },
	{ ClkClientWin,         MODKEY,              Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,              Button3,        resizemouse,    {0} },
	{ ClkClientWin,         MODKEY|ShiftMask,    Button3,        dragcfact,      {0} },
	{ ClkClientWin,         MODKEY|ShiftMask,    Button1,        dragmfact,      {0} },
	{ ClkTagBar,            0,                   Button1,        view,           {0} },
	{ ClkTagBar,            0,                   Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,              Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,              Button3,        toggletag,      {0} },
};

