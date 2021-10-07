defmodule FunExTest do
  use ExUnit.Case
  doctest FunEx

  import Mox

  setup :set_mox_from_context

  @date "2020-01-01"
  @territory "england-and-wales"
  @expected_result %{
    "bunting" => true,
    "date" => "2020-01-01",
    "notes" => "",
    "title" => "New Year’s Day"
  }
  @file_read_result File.read("bank_holidays.json")
  @holidays_data File.read("bank_holidays.json") |> elem(1) |> Jason.decode()

  test "V1 Controller" do
    assert FunEx.V1.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V1 GenServer" do
    {:ok, pid} = FunEx.V1.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  test "V2 Controller" do
    assert FunEx.V2.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V2 GenServer" do
    {:ok, pid} = FunEx.V2.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  test "V3 Controller" do
    assert FunEx.V3.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V3 GenServer" do
    {:ok, pid} = FunEx.V3.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  test "V4 Controller" do
    assert FunEx.V4.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V4 GenServer" do
    {:ok, pid} = FunEx.V4.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  test "V5 Controller" do
    Test.FileMock
    |> expect(:read, fn _ -> @file_read_result end)

    Test.LoggerMock
    |> expect(:info, fn _ -> :ok end)

    assert FunEx.V5.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V5 GenServer" do
    Test.FileMock
    |> expect(:read, fn _ -> @file_read_result end)

    Test.LoggerMock
    |> expect(:info, fn _ -> :ok end)

    {:ok, pid} = FunEx.V5.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  test "V6 Controller" do
    setup_mocks()

    assert FunEx.V6.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V6 GenServer" do
    setup_mocks()

    {:ok, pid} = FunEx.V6.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  test "V7 Controller" do
    setup_mocks()

    assert FunEx.V7.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V7 GenServer" do
    setup_mocks()

    {:ok, pid} = FunEx.V7.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  test "V8 Controller" do
    setup_mocks()

    assert FunEx.V8.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V8 GenServer" do
    setup_mocks()

    {:ok, pid} = FunEx.V8.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  test "V9 Controller" do
    setup_mocks()

    assert FunEx.V9.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V9 GenServer" do
    setup_mocks()

    {:ok, pid} = FunEx.V9.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  test "V10 Controller" do
    setup_mocks()

    assert FunEx.V10.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V10 GenServer" do
    setup_mocks()

    {:ok, pid} = FunEx.V10.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  test "V11 Controller" do
    setup_mocks()

    assert FunEx.V11.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V11 GenServer" do
    setup_mocks()

    {:ok, pid} = FunEx.V11.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  test "V12 Controller" do
    setup_mocks()

    assert FunEx.V12.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V12 GenServer" do
    setup_mocks()

    {:ok, pid} = FunEx.V12.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  test "V13 Controller" do
    setup_mocks()

    assert FunEx.V13.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V13 GenServer" do
    setup_mocks()

    {:ok, pid} = FunEx.V13.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  defp setup_mocks() do
    Test.FileMock
    |> expect(:read, fn _ -> @file_read_result end)

    Test.LoggerMock
    |> expect(:info, fn _ -> :ok end)

    Test.StorageServiceMock
    |> expect(:fetch_holidays, fn -> @holidays_data end)
  end
end
