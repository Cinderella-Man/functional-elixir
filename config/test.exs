import Config

config :fun_ex,
  logger: Test.LoggerMock,
  file: Test.FileMock,
  storage_service: Test.StorageServiceMock
