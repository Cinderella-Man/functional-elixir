defmodule FunExTest do
  use ExUnit.Case
  doctest FunEx

  @date "2020-01-01"
  @territory "england-and-wales"
  @expected_result %{
    "bunting" => true,
    "date" => "2020-01-01",
    "notes" => "",
    "title" => "New Year’s Day"
  }

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
    assert FunEx.V5.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V5 GenServer" do
    {:ok, pid} = FunEx.V5.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  test "V6 Controller" do
    assert FunEx.V6.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V6 GenServer" do
    {:ok, pid} = FunEx.V6.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  test "V7 Controller" do
    assert FunEx.V7.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V7 GenServer" do
    {:ok, pid} = FunEx.V7.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  test "V8 Controller" do
    assert FunEx.V8.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V8 GenServer" do
    {:ok, pid} = FunEx.V8.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  test "V9 Controller" do
    assert FunEx.V9.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V9 GenServer" do
    {:ok, pid} = FunEx.V9.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  test "V10 Controller" do
    assert FunEx.V10.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V10 GenServer" do
    {:ok, pid} = FunEx.V10.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end

  test "V11 Controller" do
    assert FunEx.V11.TimeOffController.next_holiday(
             nil,
             %{"date" => @date, "territory" => @territory}
           ) == [{:result, @expected_result}]
  end

  test "V11 GenServer" do
    {:ok, pid} = FunEx.V11.TimeOffGenServer.start_link()

    assert GenServer.call(
             pid,
             {:next_holiday, @date, @territory}
           ) == @expected_result
  end
end
