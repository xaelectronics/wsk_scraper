defmodule WskScraperWeb.NumberfireControllerTest do
  use WskScraperWeb.ConnCase

  alias WskScraper.Sources

  @create_attrs %{"1b": 120.5, "2b": 120.5, "3b": 120.5, avg: 120.5, bb: 120.5, betting_site: "some betting_site", date: ~D[2010-04-17], hr: 120.5, k: 120.5, name: "some name", opp: "some opp", pa: 120.5, position: "some position", projected_fp: 120.5, r: 120.5, rbi: 120.5, salary: "some salary", sb: 120.5, team: "some team", value: 120.5}
  @update_attrs %{"1b": 456.7, "2b": 456.7, "3b": 456.7, avg: 456.7, bb: 456.7, betting_site: "some updated betting_site", date: ~D[2011-05-18], hr: 456.7, k: 456.7, name: "some updated name", opp: "some updated opp", pa: 456.7, position: "some updated position", projected_fp: 456.7, r: 456.7, rbi: 456.7, salary: "some updated salary", sb: 456.7, team: "some updated team", value: 456.7}
  @invalid_attrs %{"1b": nil, "2b": nil, "3b": nil, avg: nil, bb: nil, betting_site: nil, date: nil, hr: nil, k: nil, name: nil, opp: nil, pa: nil, position: nil, projected_fp: nil, r: nil, rbi: nil, salary: nil, sb: nil, team: nil, value: nil}

  def fixture(:numberfire) do
    {:ok, numberfire} = Sources.create_numberfire(@create_attrs)
    numberfire
  end

  describe "index" do
    test "lists all numberfire", %{conn: conn} do
      conn = get(conn, Routes.numberfire_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Numberfire"
    end
  end

  describe "new numberfire" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.numberfire_path(conn, :new))
      assert html_response(conn, 200) =~ "New Numberfire"
    end
  end

  describe "create numberfire" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.numberfire_path(conn, :create), numberfire: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.numberfire_path(conn, :show, id)

      conn = get(conn, Routes.numberfire_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Numberfire"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.numberfire_path(conn, :create), numberfire: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Numberfire"
    end
  end

  describe "edit numberfire" do
    setup [:create_numberfire]

    test "renders form for editing chosen numberfire", %{conn: conn, numberfire: numberfire} do
      conn = get(conn, Routes.numberfire_path(conn, :edit, numberfire))
      assert html_response(conn, 200) =~ "Edit Numberfire"
    end
  end

  describe "update numberfire" do
    setup [:create_numberfire]

    test "redirects when data is valid", %{conn: conn, numberfire: numberfire} do
      conn = put(conn, Routes.numberfire_path(conn, :update, numberfire), numberfire: @update_attrs)
      assert redirected_to(conn) == Routes.numberfire_path(conn, :show, numberfire)

      conn = get(conn, Routes.numberfire_path(conn, :show, numberfire))
      assert html_response(conn, 200) =~ "some updated betting_site"
    end

    test "renders errors when data is invalid", %{conn: conn, numberfire: numberfire} do
      conn = put(conn, Routes.numberfire_path(conn, :update, numberfire), numberfire: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Numberfire"
    end
  end

  describe "delete numberfire" do
    setup [:create_numberfire]

    test "deletes chosen numberfire", %{conn: conn, numberfire: numberfire} do
      conn = delete(conn, Routes.numberfire_path(conn, :delete, numberfire))
      assert redirected_to(conn) == Routes.numberfire_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.numberfire_path(conn, :show, numberfire))
      end
    end
  end

  defp create_numberfire(_) do
    numberfire = fixture(:numberfire)
    {:ok, numberfire: numberfire}
  end
end
