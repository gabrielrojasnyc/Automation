## DSC script to create message of the day
Configuration MODGPO {
    
    param($NodeVM)

    Node $NodeVM {

        Ensure = 'Present'
        Key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System'
        ValueName = 'LegalNoticeCaption'
        ValueData = 'This system is proctected by State and Federal law'
        ValueType = 'String'
    }   


}


Configuration NoLockScreenGPO {
    
    param($NodeVM)

    Node $NodeVM {

        Ensure = 'Present'
        Key = 'HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization'
        ValueName = 'NoLockScreen'
        ValueData = '1'
        ValueType = 'DWORD'
    }   


}
