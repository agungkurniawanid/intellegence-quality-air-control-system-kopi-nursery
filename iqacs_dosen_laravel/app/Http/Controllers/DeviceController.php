<?php

namespace App\Http\Controllers;

use App\Models\Amonia;
use App\Models\Dioksida;
use App\Models\Humidity;
use App\Models\Metana;
use App\Models\Temperature;
use Carbon\Carbon;
use Illuminate\Http\Request;

class DeviceController extends Controller
{
    /**
     * Display a listing of the resource.
     */






    public function temperature(Request $request)
    {
        try {
            $date = Carbon::now();
          $data =   Temperature::create([
                'id_alat' => $request->id_alat,
                'nilai_temperature' => $request->nilai,
                'created_at' => $date,
            ]);

            return response()->json(['Data Berhasil Ditambahkan', 'data' => $data]);
        } catch (\Throwable $th) {
            return response()->json('Data Gagal Ditambahkan');
        }
    }

        public function humidity(Request $request)
        {
            try {
                $date = Carbon::now();
            $data =  Humidity::create([
                    'id_alat' => $request->id_alat,
                    'nilai_humidity' => $request->nilai,
                    'created_at' => $date,
                ]);

                return response()->json(['Data Berhasil Ditambahkan', 'data' => $data]);
            } catch (\Throwable $th) {
                return response()->json('Data Gagal Ditambahkan');
            }
        }
}
