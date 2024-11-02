<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Alat extends Model
{

    use HasFactory;
    protected $table = 'alat';

    protected $primaryKey = 'id_alat';
    protected $guarded='id_alat';

    // protected $fillable = ['id_alat', 'nilai_amonia'];


}
