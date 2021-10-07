ExUnit.start()

Application.ensure_all_started(:mox)

Mox.defmock(Test.FileMock, for: FunEx.Behaviours.FileBehaviour)
Mox.defmock(Test.LoggerMock, for: FunEx.Behaviours.LoggerBehaviour)
Mox.defmock(Test.StorageServiceMock, for: FunEx.Behaviours.StorageServiceBehaviour)
