require('common')

local defines = require('defines')
local cc = defines.chat_color_codes

local tests = T{}

tests.short = {
    'Test',
    'Can I look after an item?',
    '�A�C�e����a����N�|�H',
}

tests.item = {
    'Moogle',
    [[Please get me an ]] .. cc.item .. [[Orange Juice]] .. cc.standard ..
    [[ and some ]] .. cc.item .. [[Apple Pie]] .. cc.standard,
    [[�r����]] .. cc.item .. [[���āy�x�u�i�z]] .. cc.standard ..
    [[���A����]] .. cc.item .. [[�i�b�g�x�C��]] .. cc.standard ..
    [[��]] .. cc.item .. [[�f�[�c]] .. cc.standard .. [[��p�ӂ��Ăق����N�|�I]],
}

tests.clip_issue = {
    'Makki-Chebukki',
    [[...
This line used to get clipped.]],
    [[�c�c�B
�v���b�V���̂��������A�v�������������Ȃ��`]],
}

tests.unknown = {
    '???',
    'Unknown speaker...',
    [[�s�v�c�Ȑl���c�c�B]],
}

tests.homepoint = {
    '',
    'A home point can be set as a spot for you to return to Vana\'diel when you have been knocked out. You can also use a home point to teleport to other home points.',
    [[�����ł̓z�[���|�C���g�𗘗p���āA
�퓬�s�\���̋A���ė���ʒu�̐ݒ��
���̃z�[���|�C���g�ւ̃��[�v���ł��܂��B]],
}

tests.colors = {
    'Test',
    [[�P]] .. cc.item .. [[Item]] .. cc.standard .. ', ' ..
    [[�Q]] .. cc.key_item .. [[Key item]] .. cc.standard .. ', ' ..
    [[�R]] .. cc.blue .. [[Blue]] .. cc.standard .. ', ' ..
    [[�S]] .. cc.magenta .. [[Equipment?]] .. cc.standard .. ', ' ..
    [[�T]] .. cc.cyan .. [[Cyan]] .. cc.standard .. ', ' ..
    [[�U]] .. cc.yellow .. [[Yellow]] .. cc.standard .. ', ' ..
    [[�V]] .. cc.orange .. [[Orange]] .. cc.standard,

    [[�P]] .. cc.item .. [[�A�C�e��]] .. cc.standard .. ', ' ..
    [[�Q]] .. cc.key_item .. [[�厖�Ȃ���]] .. cc.standard .. ', ' ..
    [[�R]] .. cc.blue .. [[��]] .. cc.standard .. ', ' ..
    [[�S]] .. cc.magenta .. [[�����H]] .. cc.standard .. ', ' ..
    [[�T]] .. cc.cyan .. [[�V�A���F]] .. cc.standard .. ', ' ..
    [[�U]] .. cc.yellow .. [[���F]] .. cc.standard .. ', ' ..
    [[�V]] .. cc.orange .. [[�I�����W�F]] .. cc.standard
}

tests.bahamut = {
    'Bahamut',
    "Selh'teus proved that to us ten thousand years ago. Destruction is your destiny. You cannot escape what has already been decided.",
    [[������_�̗͂������Ă��A
���܂������l���~�����Ƃ͂ł���B
���܂������͊��Ɏ���ł���B
���ɂ���ċ����ʂĂ���ɂ����Ȃ��B]],
}

return tests