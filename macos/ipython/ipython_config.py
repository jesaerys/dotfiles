from IPython.terminal.prompts import Token

c.InteractiveShell.automagic = True
c.TerminalInteractiveShell.editing_mode = 'vi'
c.TerminalInteractiveShell.editor = 'vi'
c.TerminalInteractiveShell.highlighting_style = 'default'
c.TerminalInteractiveShell.highlighting_style_overrides = {
    Token.Prompt: '#ansidarkblue', Token.PromptNum: '#ansidarkblue bold',
    Token.OutPrompt: '#ansidarkred', Token.OutPromptNum: '#ansidarkred bold'}
