<?php

namespace App\Http\Controllers;

use App\Models\Alat;
use App\Models\Amonia;
use App\Models\Dioksida;
use App\Models\Humidity;
use App\Models\Metana;
use App\Models\Temperature;
use Illuminate\Http\Request;

class ChartsController extends Controller
{

    private function getLatestData($id_alat)
    {
        return [
            'Humidity' => Humidity::where('id_alat', $id_alat)->latest()->first(),
            'Temperature' => Temperature::where('id_alat', $id_alat)->latest()->first(),
        ];
    }

    public function index()
    {
        // Mengambil semua data alat
        $alat = Alat::all();
        $data = []; // Inisialisasi variabel $data sebagai array kosong

        // Loop melalui setiap alat untuk mendapatkan data Humidity dan Temperature terbaru
        foreach ($alat as $value) {
            $latestData = $this->getLatestData($value->id_alat); // Panggil sekali untuk menghemat query

            // Menyimpan data Humidity dan Temperature ke dalam array $data
            $data[] = [
                'id_alat' => $value->id_alat, // Menyimpan id_alat
                'nama_alat' => $value->nama_alat, // Nama alat
                'Humidity' => $latestData['Humidity'], // Data Humidity terbaru
                'Temperature' => $latestData['Temperature'] // Data Temperature terbaru
            ];
        }

        // Mengembalikan tampilan 'dashboard' dengan data yang sudah disiapkan
        return view('dashboard', ['alatData' => $data]);
    }



    public function dioksida(Request $request, $id)
    {
        try {
            $speeds = Dioksida::where('id_alat', $id)->latest()->take(30)->get()->sortBy('id_dioksida');
            $labels = $speeds->pluck('created_at')->map(function ($date) {
                return $date->format('H:i');
            })->toArray();
            $data = $speeds->pluck('nilai_dioksida')->toArray();

            // Ambil 1 data terakhir
            $latestData = Dioksida::latest()->first();

            return response()->json([
                'labels' => $labels,
                'data' => $data,
                'latest' => [
                    'id_dioksida' => $latestData->id_dioksida,
                    'nilai_dioksida' => $latestData->nilai_dioksida,
                    'created_at' => $latestData->created_at,
                    'updated_at' => $latestData->updated_at,
                ],
            ]);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function detaildashboard(Request $request, $id)
    {
        return view('dashboard/detaildashboard');
    }

    public function metana(Request $request, $id)
    {
        try {
            $speeds = Metana::where('id_alat', $id)->latest()->take(30)->get()->sortBy('id_metana');
            $labels = $speeds->pluck('created_at')->map(function ($date) {
                return $date->format('H:i');
            })->toArray();
            $data = $speeds->pluck('nilai_metana')->toArray();

            $latestData = Metana::latest()->first();

            return response()->json([
                'labels' => $labels,
                'data' => $data,
                'latest' => [
                    'id_metana' => $latestData->id_metana,
                    'nilai_metana' => $latestData->nilai_metana,
                    'created_at' => $latestData->created_at,
                    'updated_at' => $latestData->updated_at,
                ],
            ]);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function humidity(Request $request, $id)
    {
        try {
            $speeds = Humidity::where('id_alat', $id)->latest()->take(30)->get()->sortBy('id_humidity');
            $labels = $speeds->pluck('created_at')->map(function ($date) {
                return $date->format('H:i');
            })->toArray();
            $data = $speeds->pluck('nilai_humidity')->toArray();

            $latestData = Humidity::latest()->first();

            return response()->json([
                'labels' => $labels,
                'data' => $data,
                'latest' => [
                    'id_humidity' => $latestData->id_humidity,
                    'nilai_humidity' => $latestData->nilai_humidity,
                    'created_at' => $latestData->created_at,
                    'updated_at' => $latestData->updated_at,
                ],
            ]);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function temperature(Request $request, $id)
    {
        try {
            $speeds = Temperature::where('id_alat', $id)->latest()->take(30)->get()->sortBy('id_temp');
            $labels = $speeds->pluck('created_at')->map(function ($date) {
                return $date->format('H:i');
            })->toArray();
            $data = $speeds->pluck('nilai_temperature')->toArray();

            $latestData = Temperature::latest()->first();

            return response()->json([
                'labels' => $labels,
                'data' => $data,
                'latest' => [
                    'id_temp' => $latestData->id_temp,
                    'nilai_temperature' => $latestData->nilai_temperature,
                    'created_at' => $latestData->created_at,
                    'updated_at' => $latestData->updated_at,
                ],
            ]);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function amonia(Request $request, $id)
    {
        try {
            $speeds = Amonia::where('id_alat', $id)->latest()->take(30)->get()->sortBy('id_amonia');
            $labels = $speeds->pluck('created_at')->map(function ($date) {
                return $date->format('H:i');
            })->toArray();
            $data = $speeds->pluck('nilai_amonia')->toArray();

            $latestData = Amonia::latest()->first();

            return response()->json([
                'labels' => $labels,
                'data' => $data,
                'latest' => [
                    'id_amonia' => $latestData->id_amonia,
                    'nilai_amonia' => $latestData->nilai_amonia,
                    'created_at' => $latestData->created_at,
                    'updated_at' => $latestData->updated_at,
                ],
            ]);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
}
